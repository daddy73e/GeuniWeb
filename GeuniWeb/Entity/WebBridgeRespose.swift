//
//  WebBridgeRespose.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public struct WebBridgeRespose {
    public let jsonString: String?

    public init(
        jsonString: String? = nil
    ) {
        self.jsonString = jsonString
    }
}

extension WebBridgeRespose: ToJavascriptMessageMapping {
    public func toJavascriptMessage(withRequestId requestId: RequestID, isSuccess: Bool = true) -> String {
        // jsonString이 nil이거나 ""이면 "{}"으로 전달
        var params = "{}"
        if let nonNilJsonString = jsonString,
           !nonNilJsonString.isEmpty {
            params = nonNilJsonString
        }
        return CodableWebBridgeResponse(
            requestId: requestId,
            isOk: isSuccess,
            params: params
        ).toJavascriptMessage()
    }
}
