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
    func callBridgeViewAction(actionType: WebBridgeRequest, completion: (() -> Void)?)
    func showPopup(popupInfo: PopupInput)
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
        case .closeWeb,
                .showPopup,
                .generateBarcode,
                .showToast,
                .updatePushStatus,
                .openCamera:
            self.callBridgeAction(
                type: request,
                scriptMessage: responseMessage
            )
        case .updateConfigure(let configureType):
            switch configureType {
            case .baseURL(let environmentType):
                /// 환경 변경, 로그아웃 시키고 메인
                self.logout { [weak self] in
                    AppConfigure.shared.enviromentType = environmentType
                    self?.callBridgeAction(
                        type: request,
                        scriptMessage: responseMessage
                    )
                }
            case .screen(let screenMode):
                AppConfigure.shared.screenMode = screenMode
                self.callBridgeAction(
                    type: request,
                    scriptMessage: responseMessage
                )
            default:
                break
            }

        case .login(let loginType, _):
            switch loginType {
            case .apple, .kakao:
                loginAction(type: loginType) { [weak self] in
                    self?.callBridgeAction(
                        type: request,
                        scriptMessage: responseMessage
                    )
                }
            case .facebook, .payco:
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
        case .userDefaults(let type):
            self.userDefaultsAction(type: type) { [weak self] savedDictionary in
                if let dictionary = savedDictionary {
                    self?.addParamsToCallbackResponse(
                        responseMessage: responseMessage,
                        params: [
                            "name": (dictionary["key"] as? String)  ?? "",
                            "value": (dictionary["value"] as? String) ?? ""
                        ]
                    )
                } else {
                    self?.sendCallbackToWeb(
                        javascriptMessage: responseMessage
                    )
                }
            }
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
        self.webDelegate?.callBridgeViewAction(
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

    private func userDefaultsAction(
        type: UserDefaultActionType,
        completion: (([String: Any?]?) -> Void)?
    ) {
        switch type {
        case .write(let key, let value):
            UserDefaultsUseCase().write(input: .init(key: key, value: value))
            completion?(nil)
        case .read(let key):
            let value = UserDefaultsUseCase().read(input: .init(key: key)).value
            completion?([
                "key": key,
                "value": value
            ])
        case .remove(let key):
            UserDefaultsUseCase().delete(input: .init(key: key))
            completion?(nil)
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
                    key: UserDefaultKey.appleIDKey.rawValue,
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
        SNSLoginManager.shared.requestLogout { error in
            if let error = error {
                self.webDelegate?.showPopup(popupInfo: .init(
                    title: "오류",
                    contents: "로그아웃 에러, \(error.localizedDescription)",
                    completion: nil
                ))
            } else {
                NotificationCenter.default.post(name: Notification.Name.logout, object: nil)
            }
            completion?()
        }
    }

    /// 특정 파라미터를 담아 웹으로 보낼경우
    private func addParamsToCallbackResponse(
        responseMessage: String,
        params: [String: Any]
    ) {
        var javascriptMessage = ""
        if var responseDictionary = responseMessage.toResponseDictionary() {
            responseDictionary["responseData"] = params
            javascriptMessage = responseDictionary.toJavascriptMessage() ?? ""
        }

        self.sendCallbackToWeb(
            javascriptMessage: javascriptMessage
        )
    }

    /// 일반적인 자바스크립트 콜백
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
