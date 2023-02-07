//
//  WebBridgeViewController.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import UIKit
import WebKit

final class WebBridgeViewController: UIViewController {

    @IBOutlet weak var safeAreaFrame: UIView!
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

private extension WebBridgeViewController {
    func configureUI() {
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
}

extension WebBridgeViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        WebBridge.shared.requestWebCallback(
            viewController: userContentController,
            message: message,
            webDelegate: self
        )
    }
}

extension WebBridgeViewController: WebBridgeDelegate {
    func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            self?.webview.evaluateJavaScript(javaScriptString, completionHandler: completionHandler)
        }
    }
}

extension WebBridgeViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame == false {
            webView.load(navigationAction.request)
            return nil
        }
        return nil
    }
}

extension WebBridgeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let navigateURL = navigationAction.request.url else {
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
