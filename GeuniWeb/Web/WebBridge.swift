//
//  WebBridge.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import Foundation
import WebKit

public protocol WebCallbackDataReceivable: AnyObject {
    func receiveCallbackData(jsonDic: [String: Any])
}

protocol WebBridgeDelegate: AnyObject {
    func evaluateJavaScript(_ javaScriptString: String, completion: ((Any?, Error?) -> Void)?)
    func closeSubWebView()
}

public class WebBridge {
    var viewController: WKUserContentController?
    var scriptMessage: WKScriptMessage?
    var webDelegate: WebBridgeDelegate?
    public static let shared = WebBridge()

    func requestWebCallback(
        viewController: WKUserContentController,
        message: WKScriptMessage,
        webDelegate: WebBridgeDelegate
    ) {
        self.viewController = viewController
        self.scriptMessage = message
        self.webDelegate = webDelegate
        self.routeMessageCase(message: message)
    }

    private func routeMessageCase(message: WKScriptMessage) {
        let message = message.toWKScriptMessageMapper()
        guard let request = message?.toWebBridgeRequest(),
            let requestId = message?.toRequestId()
        else {
            return
        }
        let webBridgeAction = WebBridgeAction(requestID: requestId)
        webBridgeAction.execute(request: request) { [weak self] _ in
            /* 웹으로 콜백 */
            self?.sendCallbackToWeb(
                javascriptMessage: WebBridgeRespose(
                    jsonString: message?.toJSONString()
                ).toJavascriptMessage(withRequestId: requestId)
            )
        }
    }
    private func sendCallbackToWeb(
        javascriptMessage: String
    ) {
#if DEBUG
        let log = """
        ----- 📤 Bridging Response Start -----
        [📦] Java Script String: \n\(javascriptMessage)
        ----- 📤 Bridging Response End -----\n
        """
        print(log)
#endif
        webDelegate?.evaluateJavaScript(javascriptMessage, completion: nil)
    }
}
