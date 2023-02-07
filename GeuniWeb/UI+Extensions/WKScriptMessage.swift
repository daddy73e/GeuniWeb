//
//  WKScriptMessage.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation
import WebKit

public extension WKScriptMessage {

    func toWKScriptMessageMapper() -> WKScriptMessageMapper? {
        return (body as? String)?.toDictionary()
    }
}
