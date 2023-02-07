//
//  CodableWebBridgeResponse.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public struct CodableWebBridgeResponse: Codable {
    /// 응답 콜백 ID
    public let requestId: String
    /// 성공/실패 여부
    public let isOk: Bool
    /// 응답 데이터
    public var params: String
    
    public init(
        requestId: String,
        isOk: Bool,
        params: String
    ) {
        self.requestId = requestId
        self.isOk = isOk
        self.params = params
    }
    
    func toJavascriptMessage() -> String {
        guard let data = try? JSONEncoder().encode(self),
              let message = String(data: data, encoding: .utf8)
        else {
            return ""
        }
        return "callbackListener(\(message))"
    }
}
