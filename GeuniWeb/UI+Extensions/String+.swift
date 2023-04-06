//
//  String+.swift
//  GeuniModule
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public extension String {
    func toDictionary() -> [String: Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        return data.toDictionary()
    }
    
    func toResponseDictionary() -> [String: Any]? {
        let removeCallbackListener: String = String(self.replacingOccurrences(
            of: "callbackListener(",
            with: ""
        ).dropLast())
        return removeCallbackListener.toDictionary()
    }
}
