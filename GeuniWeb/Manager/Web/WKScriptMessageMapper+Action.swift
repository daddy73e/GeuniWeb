//
//  WKScriptMessageMapper+Action.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/07.
//

import Foundation

public extension WKScriptMessageMapper {
    func navigatorAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "goPrevPageWithData":
            return .closeWeb(params?.toJSONString() ?? "")
        case "goWebPage":
            let path = (params?["path"] as? String) ?? ""
            return .openNewWebPage(path)
        default:
            return nil
        }
    }

    func notificationAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "popup":
            if let params = params as? [String: String] {
                return .showPopup(params)
            } else {
                return nil
            }
        case "toast":
            if let params = params as? [String: String] {
                return .showToast(params)
            } else {
                return nil
            }
        default:
            return nil
        }
    }

    func logoutAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "logout":
            return .logout
        default:
            return nil
        }
    }

    func loginAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "loginSNS":
            let type = (params?["type"] as? String) ?? ""
            return .login(loginType: .init(fromRawValue: type), error: nil)
        default:
            return nil
        }
    }

    func localStorageAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "writeLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            let value = (params?["value"] as? String) ?? ""
            return .userDefaults(type: .write(key: key, value: value))
        case "readLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            return .userDefaults(type: .read(key: key))
        case "removeLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            return .userDefaults(type: .remove(key: key))
        default:
            return nil
        }
    }

    func apiRequestAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "requestTest":
            return .requestAPI
        default:
            return nil
        }
    }

    func configurationAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "baseURL":
            let configure = (params?["configure"] as? String) ?? ""
            return .updateConfigure(type: .baseURL(type: .init(fromRawValue: configure)))
        case "screen":
            let screenMode = (params?["screenMode"] as? String) ?? ""
            return .updateConfigure(type: .screen(type: .init(fromRawValue: screenMode)))
        default:
            return nil
        }
    }

    func generateAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "barcode":
            let code = (params?["code"] as? String) ?? ""
            return .generateBarcode(code: code)
        default:
            return nil
        }
    }

    func cameraAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "open":
            return .openCamera
        default:
            return nil
        }
    }
}
