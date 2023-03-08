//
//  ConfigureType.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/08.
//

public enum ConfigureType {
    case none
    case baseURL(type: EnvironmentType)
    case screen(type: ScreenType)
}

public enum EnvironmentType: String {
    case production
    case develop
    case test
    case mock

    init(fromRawValue: String) {
        self = EnvironmentType(rawValue: fromRawValue) ?? .develop
    }
}

public enum ScreenType: String {
    case fullScreen
    case safeArea

    init(fromRawValue: String) {
        self = ScreenType(rawValue: fromRawValue) ?? .safeArea
    }
}
