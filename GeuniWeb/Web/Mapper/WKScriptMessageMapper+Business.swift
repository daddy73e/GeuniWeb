//
//  WKScriptMessageMapper+Business.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/02.
//

import Foundation

extension WKScriptMessageMapper {
    func toWebBridgeBusinessRequest(action: String, params: [String: Any]?) -> WebBridgeRequest? {
        switch action {
        case "writeLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            let value = (params?["value"] as? String) ?? ""
            return .bussiness(.userDefault(type: .write(key: key, value: value)))
        case "readLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            return .bussiness(.userDefault(type: .read(key: key)))
        case "removeLocalStorage":
            let key = (params?["key"] as? String) ?? ""
            return .bussiness(.userDefault(type: .remove(key: key)))
        default:
            return nil
        }
    }
}
