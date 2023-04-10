//
//  WKScriptMessageMapper.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public typealias WKScriptMessageMapper = [String: Any]
public typealias RequestID = String

public extension WKScriptMessageMapper {
    func toRequestId() -> RequestID? {
        return self["requestId"] as? String
    }

    func toWebBridgeRequest() -> WebBridgeRequest? {
        guard let serviceName = self["serviceName"] as? String,
              let action = self["action"] as? String,
              let params = self["params"] as? [String: Any]?
        else {
            return nil
        }

#if DEBUG
        let log = """
        ----- 📨 Web Bridge Request Start -----
        [🎯] Service Name: \(serviceName)
        [🕹] Action: \(action)
        [🆔] Request ID: \(toRequestId() ?? "")
        [📦] Params: \n\(params ?? [:])
        ----- 📨 Web Bridge Request End -----\n
        """
        print(log)
#endif

        return routeService(
            serviceName: serviceName,
            action: action,
            params: params
        )
    }

    func routeService(
        serviceName: String,
        action: String,
        params: [String: Any]?
    ) -> WebBridgeRequest? {
        switch serviceName {
        case "Navigator":
            return navigatorAction(action: action, params: params)
        case "Notification":
            return notificationAction(action: action, params: params)
        case "LogOut":
            return logoutAction(action: action, params: params)
        case "Login":
            return loginAction(action: action, params: params)
        case "LocalStorage":
            return localStorageAction(action: action, params: params)
        case "APIRequest":
            return apiRequestAction(action: action, params: params)
        case "Configuration":
            return configurationAction(action: action, params: params)
        case "Generate":
            return generateAction(action: action, params: params)
        case "Camera":
            return cameraAction(action: action, params: params)
        default:
            return nil
        }
    }
}
