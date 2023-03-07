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
    func callBridgeAction(actionType: WebBridgeRequest, completion: (() -> Void)?)
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

        let responseMessage = WebBridgeRespose(
            jsonString: message?.toJSONString()
        ).toJavascriptMessage(withRequestId: requestId)

        switch request {
        case .closeWeb, .showAlertPopup:
            self.callBridgeAction(
                type: request,
                scriptMessage: responseMessage
            )
        case .login(let loginType, _):
            switch loginType {
            case .apple, .kakao:
                loginAction(type: loginType) { [weak self] in
                    self?.callBridgeAction(
                        type: request,
                        scriptMessage: responseMessage
                    )
                }
            case .facebook:
                self.callBridgeAction(
                    type: request,
                    scriptMessage: responseMessage
                )
            default:
                break
            }
        case .logout:
            self.logout { [weak self] in
                self?.callBridgeAction(
                    type: request,
                    scriptMessage: responseMessage
                )
            }
        case .userDefault(let type):
            userDefaultAction(type: type)
            self.sendCallbackToWeb(javascriptMessage: responseMessage)
        case .requestAPI:
            self.requestAPI {[weak self] in
                self?.sendCallbackToWeb(javascriptMessage: responseMessage)
            }
        }
    }

    private func callBridgeAction(
        type: WebBridgeRequest,
        scriptMessage: String
    ) {
        /* ViewController 에서 동작 */
        self.webDelegate?.callBridgeAction(
            actionType: type,
            completion: { [weak self] in
                /* 웹 자바스크립트 콜백 */
                self?.sendCallbackToWeb(
                    javascriptMessage: scriptMessage
                )
            }
        )
    }

    private func requestAPI(completion: (() -> Void)?) {
        Loading.shared.show()
        APIManager.shared.request { _, _ in
            Loading.shared.hide()
        }
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

    private func loginAction(
        type: SNSLoginType,
        completion: (() -> Void)?
    ) {
        switch type {
        case .apple:
            SNSLoginManager.shared.requestAppleLogin { userInfo in
                let keyCainUseCase = KeychainUseCase()
                keyCainUseCase.write(input: .init(
                    key: AppConfigure.shared.appleIDKey,
                    saveData: userInfo?.userID
                ))
                completion?()
            }
        case .kakao:
            SNSLoginManager.shared.requestKakaoLogin { _ in
                completion?()
            }
        default:
            completion?()
        }
    }

    private func logout(completion: (() -> Void)?) {
        SNSLoginManager.shared.requestLogout {
            NotificationCenter.default.post(name: Notification.Name.logout, object: nil)
            completion?()
        }
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
        webDelegate?.evaluateJavaScript(javascriptMessage, completion: nil)
    }
}
