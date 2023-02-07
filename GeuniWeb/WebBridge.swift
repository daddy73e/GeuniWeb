//
//  WebBridge.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import Foundation
import WebKit

protocol WebBridgeDelegate: AnyObject {
    func evaluateJavaScript(_ javaScriptString: String, completionHandler: ((Any?, Error?) -> Void)?)
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
        let requestId = message?.toRequestId()
        let request = message?.toWebBridgeRequest()
        
        /* 분기별 처리 */
        
        
        
        /* 웹으로 콜백 */
        sendCallbackToWeb(
            javascriptMessage: WebBridgeRespose(
                jsonString: message?.toJSONString()
            ).toJavascriptMessage(withRequestId: requestId ?? "")
        )
    }
    
    
    private func sendCallbackToWeb(javascriptMessage: String) {
        
#if DEBUG
        let log = """
        ----- 📤 Bridging Response Start -----
        [📦] Java Script String: \n\(javascriptMessage)
        ----- 📤 Bridging Response End -----\n
        """
        print(log)
#endif
        webDelegate?.evaluateJavaScript(javascriptMessage, completionHandler: nil)
    }
}
