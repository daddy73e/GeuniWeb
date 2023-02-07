//
//  ToJavascriptMessageMapping.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public protocol ToJavascriptMessageMapping {
    func toJavascriptMessage(withRequestId requestId: RequestID, isSuccess: Bool) -> String
}
