//
//  Dictionary+.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/05.
//

import Foundation

public extension Dictionary where Key == String {
    func toJSONData() -> Data? {
        guard JSONSerialization.isValidJSONObject(self) else {
            return nil
        }
        return try? JSONSerialization.data(withJSONObject: self, options: [])
    }
    func toJSONString() -> String? {
        guard let data = self.toJSONData() else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
