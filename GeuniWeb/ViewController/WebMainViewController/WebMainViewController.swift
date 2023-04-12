//
//  WebMainViewController.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import UIKit
import WebKit

public protocol WebMainViewDelegate: AnyObject {
    func closeWebMain(sendData: Any?)
}

public final class WebMainViewController: UIViewController, UINavigationControllerDelegate {
    public var delegate: WebMainViewDelegate?
    
    public var homeUrl: URL?
    private var messageHandlerName = AppConfigure.shared.webBridgeMessageHandlerName
    private var rootContainer = UIView()
    private var webview: WKWebView?
    private var sampleImageView: UIImageView?
    private var networkStatusManager = NetworkStatusManager.shared

    private var marginTop = NSLayoutConstraint()
    private var marginBottom = NSLayoutConstraint()
    private var marginLeft = NSLayoutConstraint()
    private var marginRight = NSLayoutConstraint()

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        configureUI()
        
        routeURL()
        
        
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let webView = self.webview {
            webView.frame = self.rootContainer.bounds
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addNotification()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Toast.shared.hide(animate: false)
        removeNotification()
    }

    /// 로그아웃 완료됨
    @objc func navigateLoginPage(_ notification: Notification) {
        print("navigateLoginPage")
    }

    @objc func keyboardWillShow(_ notification: Notification) { }

    @objc func keyboardWillHide(_ notification: Notification) { }
}

private extension WebMainViewController {

    func configureUI() {
        sampleImageView = UIImageView(frame: .zero)

        guard let webview = self.webview else {
            return
        }

        guard let barcodeImageView = sampleImageView else {
            return
        }

        barcodeImageView.translatesAutoresizingMaskIntoConstraints = false
        barcodeImageView.contentMode = .scaleAspectFit

        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .yellow
        self.rootContainer.backgroundColor = .green
        self.view.addSubview(rootContainer)
        self.rootContainer.addSubview(webview)
        self.rootContainer.addSubview(barcodeImageView)

        rootContainer.translatesAutoresizingMaskIntoConstraints = false
        webview.translatesAutoresizingMaskIntoConstraints = false
        webview.autoresizingMask = [.flexibleLeftMargin, .flexibleTopMargin]
        marginLeft = rootContainer.leadingAnchor.constraint(
            equalTo: self.view.leadingAnchor,
            constant: AppConfigure.shared.screenMode == .safeArea ? self.view.safeAreaInsets.left : 0.0
        )
        marginRight = rootContainer.trailingAnchor.constraint(
            equalTo: self.view.trailingAnchor,
            constant: AppConfigure.shared.screenMode == .safeArea ? -self.view.safeAreaInsets.right : 0.0
        )
        marginTop = rootContainer.topAnchor.constraint(
            equalTo: self.view.topAnchor,
            constant: AppConfigure.shared.screenMode == .safeArea ? self.view.safeAreaInsets.top : 0.0
        )
        marginBottom = rootContainer.bottomAnchor.constraint(
            equalTo: self.view.bottomAnchor,
            constant: AppConfigure.shared.screenMode == .safeArea ? -self.view.safeAreaInsets.bottom : 0.0
        )
        NSLayoutConstraint.activate([
            marginTop,
            marginBottom,
            marginLeft,
            marginRight
        ])

        NSLayoutConstraint.activate([
            barcodeImageView.leadingAnchor.constraint(
                equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50
            ),
            barcodeImageView.widthAnchor.constraint(equalToConstant: 200),
            barcodeImageView.heightAnchor.constraint(equalToConstant: 50),
            barcodeImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }

    func configureWebView() {
        let userContentController = WKUserContentController()
        userContentController.add(self, name: messageHandlerName)
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        self.webview = WKWebView(frame: .zero, configuration: configuration)
        self.webview?.uiDelegate = self
        self.webview?.navigationDelegate = self
    }

    func routeURL() {
        var baseURL: URL?
        if homeUrl == nil {
            guard let url = AppConfigure.shared.baseUrl else { return }
            baseURL = url
        } else {
            guard let url = homeUrl else { return }
            baseURL = url
        }
        if let url = baseURL {
            loadURL(url: url)
        }
    }
    
    func loadURL(url: URL) {
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        webview?.load(urlRequest)
    }

    func closeWebMain(sendData: String?, completion: (() -> Void)?) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
            self.delegate?.closeWebMain(sendData: sendData)
            completion?()
        } else {
            self.dismiss(animated: true) { [weak self] in
                self?.delegate?.closeWebMain(sendData: sendData)
                completion?()
            }
        }
    }

    func updateScreenMode(type: ScreenType) {
        var constantLeft = 0.0
        var constantRight = 0.0
        var constantTop = 0.0
        var constantBottom = 0.0
        switch type {
        case .safeArea:
            constantLeft = self.view.safeAreaInsets.left
            constantRight = -self.view.safeAreaInsets.right
            constantTop = self.view.safeAreaInsets.top
            constantBottom = -self.view.safeAreaInsets.bottom
        default:
            break
        }
        marginLeft.constant = constantLeft
        marginRight.constant = constantRight
        marginTop.constant = constantTop
        marginBottom.constant = constantBottom
    }
}

extension WebMainViewController: WKScriptMessageHandler {
    public func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        WebBridge.shared.requestWebCallback(
            viewController: userContentController,
            message: message,
            webDelegate: self
        )
    }
}

extension WebMainViewController: WebBridgeDelegate {
    func showPopup(popupInfo: PopupInput) {
        Router.shared.showPopup(fromVC: self, popupInput: popupInfo)
    }

    // swiftlint:disable function_body_length
    // swiftlint:disable cyclomatic_complexity
    func callBridgeViewAction(
        actionType: WebBridgeRequest,
        completion: (() -> Void)?
    ) {
        switch actionType {
        case .updateConfigure(let configureType):
            switch configureType {
            case .baseURL:
                completion?()
                Router.shared.restart(fromVC: self) { }
            case .screen(let type):
                Task { @MainActor in
                    self.updateScreenMode(type: type)
                    self.view.setNeedsLayout()
                    completion?()
                }
            default:
                completion?()
            }

        case .closeWeb(let string):
            closeWebMain(sendData: string, completion: completion)
        case .showPopup(let dictionary):
            Router.shared.showPopup(
                fromVC: self,
                popupInput: .init(
                    title: dictionary["title"] ?? "",
                    contents: dictionary["contents"] ?? "",
                    yesText: dictionary["yesText"] ?? "",
                    noText: dictionary["noText"] ?? "",
                    completion: { output in
                        print("output = \(output)")
                        completion?()
                    }
                )
            )
        case .showToast(let dictionary):
            let message = dictionary["message"] ?? ""
            Toast.shared.show(
                option: .init(
                    backgroundView: self.view,
                    message: message
                )
            ) {
                completion?()
            }
        case .logout:
            /* 로그인화면으로 이동 */
            completion?()
        case .login(let loginType, _):
            /* 페이지 이동 */
            switch loginType {
            case .facebook:
                SNSLoginManager.shared.requestFacebookLogin(viewController: self) { userInfo in
                    print(userInfo ?? "")
                    completion?()
                }
            case .payco:
                SNSLoginManager.shared.requestPaycoLogin { _ in
                    completion?()
                }
            default:
                completion?()
            }
        case .generateBarcode(let code):
            generateBarcode(code: code) { [weak self] barcodeImage in
                self?.sampleImageView?.image = barcodeImage
                completion?()
            }
        case .updatePushStatus(let isOn):
            if isTargetSimulator() {
                Toast.shared.show(option: .init(
                    backgroundView: self.view,
                    message: "시뮬레이터에서는 테스트할 수 없습니다."
                ))
                return
            }
            PushManager.shared.updatePushNotificationStatus(isOn: isOn) { [weak self] isSucces in
                guard let self = self else { return }
                if isSucces {
                    completion?()
                } else {
                    Router.shared.showPopup(
                        fromVC: self,
                        popupInput: .init(
                            title: "알림",
                            contents: "알림 설정 필요",
                            yesText: "확인",
                            noText: "취소",
                            completion: { output in
                                if output.result {
                                    Router.shared.openSettingPage()
                                }
                                completion?()
                            }
                        )
                    )
                }
            }
        case .openCamera:
            CameraUseCase().checkPermission { permission in
                switch permission {
                case .enableCameraAlbum:
                    self.openCamera {
                        completion?()
                    }
                case .disableCamera:
                    Router.shared.showPopup(
                        fromVC: self,
                        popupInput: .init(
                            title: "카메라 권한 설정이 필요합니다.",
                            completion: { output in
                                completion?()
                                if !output.result {
                                    return
                                }
                                Router.shared.openSettingPage()
                            }
                        )
                    )
                case .disableAlbum:
                    Router.shared.showPopup(
                        fromVC: self,
                        popupInput: .init(
                            title: "앨범 권한 설정이 필요합니다.",
                            completion: { output in
                                completion?()
                                if !output.result {
                                    return
                                }
                                Router.shared.openSettingPage()
                            }
                        )
                    )
                }
            }
        default:
            completion?()
        }
    }

    func evaluateJavaScript(_ javaScriptString: String, completion: ((Any?, Error?) -> Void)?) {
        Task { @MainActor in
            self.webview?.evaluateJavaScript(javaScriptString, completionHandler: completion)
        }
    }

    func closeSubWebView() {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            self.dismiss(animated: true)
        }
    }
}

extension WebMainViewController: WKUIDelegate {
    public func webView(
        _ webView: WKWebView,
        createWebViewWith configuration: WKWebViewConfiguration,
        for navigationAction: WKNavigationAction,
        windowFeatures: WKWindowFeatures
    ) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame == false {
            webView.load(navigationAction.request)
            return nil
        }
        return nil
    }
}

extension WebMainViewController: WKNavigationDelegate {
    public func webView(
        _ webView: WKWebView,
        decidePolicyFor navigationAction: WKNavigationAction,
        decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
    ) {
        guard navigationAction.request.url != nil else {
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }

    public func webView(
        _ webView: WKWebView,
        didFailProvisionalNavigation navigation: WKNavigation!,
        withError error: Error
    ) {

    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

    }
}

/* 웹메인에서 웹 메인을 호출하는 경우 callback으로 사용 */
extension WebMainViewController: WebMainViewDelegate {
    public func closeWebMain(sendData: Any?) { }
}
