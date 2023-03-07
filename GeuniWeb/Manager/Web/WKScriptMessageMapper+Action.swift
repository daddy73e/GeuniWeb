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
        default:
            return nil
        }
    }

    func customAlertAction(
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch action {
        case "showAlertPopup":
            if let params = params as? [String: String] {
                return .showAlertPopup(params)
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
            return .userDefault(type: .write(key: key, value: value))
        case "readLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            return .userDefault(type: .read(key: key))
        case "removeLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            return .userDefault(type: .remove(key: key))
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
        let configure = (params?["configure"] as? String) ?? ""
        switch action {
        case "updateConfigure":
            return .updateConfigure(type: .init(fromRawValue: configure))
        default:
            return nil
        }
    }
}
