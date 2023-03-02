//
//  WebMainViewController.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import UIKit
import WebKit

protocol WebMainViewDelegate: AnyObject {
    func closeWebMain(sendData: Any?)
}

final class WebMainViewController: UIViewController {

    @IBOutlet weak var safeAreaFrame: UIView!
    public var delegate: WebMainViewDelegate?
    private var messageHandlerName = "geuniModule"
    private var configuration = WKWebViewConfiguration()
    private var webview = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureWebView()
        configureUI()
        loadURL()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureLayout()
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
    func userContentController(
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
        }
    }

    func evaluateJavaScript(_ javaScriptString: String, completion: ((Any?, Error?) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            self?.webview.evaluateJavaScript(javaScriptString, completionHandler: completion)
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
    func webView(
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
    func webView(
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

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {

    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {

    }
}
