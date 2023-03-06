//
//  AppConfigure.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//
import Foundation

public class AppConfigure {
    public static let shared = AppConfigure()
    public var enviromentType: EnvironmentType = .develop

    public var appleIDKey = "GEUNI_WEB_APPLE_LOGIN_ID"

    public func kakaoAppKey() -> String? {
        guard let url = Bundle.main.url(forResource: "AppKey", withExtension: "plist") else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOf: url) else {
            return nil
        }

        return dictionary["kakaoAppKey"] as? String
    }

    public func baseURL() -> String {
        switch enviromentType {
        case .production:
            return "https://production"
        case .develop:
            return "https://swapi.dev/api/films"
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
