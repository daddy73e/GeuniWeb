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

public final class WebMainViewController: UIViewController {

    @IBOutlet weak var safeAreaFrame: UIView!
    public var delegate: WebMainViewDelegate?
    private var messageHandlerName = "geuniModule"
    private var configuration = WKWebViewConfiguration()
    private var webview = WKWebView()
    private var networkStatusManager = NetworkStatusManager.shared

    public override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        configureNetwork()
        configureUI()
        loadURL()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
    }

    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        networkStatusManager.stopMonitoring()
    }
}

private extension WebMainViewController {
    func configureUI() {
        self.navigationController?.isNavigationBarHidden = true
        safeAreaFrame.addSubview(webview)
    }

    func configureLayout() {
        webview.frame = safeAreaFrame.bounds
    }

    func configureWebView() {
        let userContentController = WKUserContentController()
        userContentController.add(self, name: messageHandlerName)
        configuration.userContentController = userContentController
        webview = WKWebView(frame: .zero, configuration: configuration)
        webview.uiDelegate = self
        webview.navigationDelegate = self
    }

    func configureNetwork() {
        networkStatusManager.delegate = self
        networkStatusManager.startMonitoring()
    }

    func loadURL() {
        let testURL = Bundle.main.url(forResource: "test", withExtension: "html")!
        var urlRequest = URLRequest(url: testURL)
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        webview.load(urlRequest)
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
    /// 웹으로 정상 호출 확인용 completion 
    func callBridgeAction(actionType: WebBridgeUIActionType, completion: (() -> Void)?) {
        switch actionType {
        case .closeWeb(let string):
            closeWebMain(sendData: string, completion: completion)
        case .showAlertPopup(let dictionary):
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
        case .logout:
            /* 페이지 초기화 */
            completion?()
        case .login(let loginType, _):
            /* 페이지 이동 */
            switch loginType {
            case .facebook:
                SNSLoginManager.shared.requestFacebookLogin(viewController: self) { userInfo in
                    completion?()
                }
            default:
                completion?()
            }
        }
    }

    func evaluateJavaScript(_ javaScriptString: String, completion: ((Any?, Error?) -> Void)?) {
        Task { @MainActor in
            self.webview.evaluateJavaScript(javaScriptString, completionHandler: completion)
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

extension WebMainViewController: NetworkStatusDelegate {
    public func observeNetworkStatus(status: NetworkStatus) {
        print("Network status = \(status)")
        switch status {
        case .notConnected:
            Router.shared.showPopup(fromVC: self, popupInput: .init(
                title: "알림",
                contents: "네트워크 연결이 끊겼습니다.",
                yesText: "확인",
                noText: "", completion: nil
            ))
        default:
            break
        }
    }
}
