//
//  AppConfigure.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

public class AppConfigure {
    public static let shared = AppConfigure()
    public var enviromentType: EnvironmentType = .develop
    public var appleIDKey = "GEUNI_WEB_APPLE_LOGIN_ID"
    public func baseURL() -> String {
        switch enviromentType {
        case .production:
            return "https://production"
        case .develop:
            return "https://develop"
        case .test:
            return "https://test"
        case .mock:
            return "https://mock"
        }
    }
    public enum EnvironmentType: String {
        case production
        case develop
        case test
        case mock
    }
}
