//
//  WKScriptMessageMapper+Navigator.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import Foundation

extension WKScriptMessageMapper {
    func toWebBridgeNavigatorRequest(action: String, params: [String: Any]?) -> WebBridgeRequest? {
        switch action {
        case "goPrevPageWithData":
            return .Navigator(
                .goPrevPageWithData(
                    params?.toJSONString() ?? ""
                )
            )
        
        default:
            return nil
        }
    }
}
