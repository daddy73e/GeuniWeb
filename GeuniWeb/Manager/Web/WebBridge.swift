//
//  WebBridge.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import Foundation
import WebKit

protocol WebBridgeDelegate: AnyObject {
    func evaluateJavaScript(_ javaScriptString: String, completion: ((Any?, Error?) -> Void)?)
    func callBridgeAction(actionType: WebBridgeUIActionType, completion: (() -> Void)?)
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

        switch request {
        case .userInteraction(let webBridgeUIActionType):
            /* UI 로직 수행*/
            webDelegate?.callBridgeAction(
                actionType: webBridgeUIActionType,
                completion: { [weak self] in
                    self?.sendCallbackToWeb(
                        javascriptMessage: WebBridgeRespose(
                            jsonString: message?.toJSONString()
                        ).toJavascriptMessage(withRequestId: requestId)
                    )
                })
        case .bussiness(let webBridgeBusinessActionType):
            /* 비즈니스 로직 수행*/
            callBridgeBussinessAction(actinType: webBridgeBusinessActionType) { [weak self] in
                self?.sendCallbackToWeb(
                    javascriptMessage: WebBridgeRespose(
                        jsonString: message?.toJSONString()
                    ).toJavascriptMessage(withRequestId: requestId)
                )
            }
        }
    }

    private func callBridgeBussinessAction(
        actinType: WebBridgeBusinessActionType,
        completion: (() -> Void)?) {
            switch actinType {
            case .userDefault(let userDefaultActionType):
                userDefaultAction(type: userDefaultActionType)
            case .snsLogin(let snsType):
                snsLoginAction(type: snsType)
            }
            completion?()
        }

    private func userDefaultAction(type: UserDefaultActionType) {
        let useCase = UserDefaultUseCase()
        switch type {
        case .write(let key, let value):
            useCase.write(input: .init(key: key, value: value))
        case .read(let key):
            if let readData = useCase.read(input: .init(key: key)).value {
                print("read data = \(readData)")
            }
        case .remove(let key):
            useCase.delete(input: .init(key: key))
        }
    }
    
    private func snsLoginAction(type: SNSLoginType) {
        let useCase = AppleLoginUseCase()
        switch type {
        case .none:
            break
        case .apple:
            useCase.requestLogin { output in
                if let loginInfo = output {
                    let keyCainUseCase = KeychainUseCase()
                    keyCainUseCase.write(input: .init(
                        key: AppConfigure.shared.appleIDKey,
                        saveData: loginInfo.user
                    ))
                }
            }
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
