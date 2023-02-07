//
//  Data.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public extension Data {
    func toDictionary() -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? [String: Any]
    }
    func toHexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}
