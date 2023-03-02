//
//  WKScriptMessageMapper+UI.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/02.
//

import Foundation

extension WKScriptMessageMapper {
    func toWebBridgeUIRequest(action: String, params: [String: Any]?) -> WebBridgeRequest? {
        switch action {
        case "goPrevPageWithData":
            return .userInteraction(.closeWeb(params?.toJSONString() ?? ""))
        case "showAlertPopup":
            if let params = params as? [String: String] {
                return .userInteraction(.showAlertPopup(params))
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}
