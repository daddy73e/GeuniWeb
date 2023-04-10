//
//  Calendar+.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/07.
//

import Foundation

public extension Calendar {
    static var shared: Calendar = {
        return Calendar(identifier: .gregorian)
    }()
}
