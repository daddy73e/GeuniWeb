//
//  Int+.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/07.
//

import Foundation

extension Int {
    var byteSize: String {
        return ByteCountFormatter().string(fromByteCount: Int64(self))
    }
}
