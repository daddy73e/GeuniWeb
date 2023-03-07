//
//  EnvironmentType.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/07.
//

public enum EnvironmentType: String {
    case production
    case develop
    case test
    case mock

    init(fromRawValue: String) {
        self = EnvironmentType(rawValue: fromRawValue) ?? .develop
    }
}
