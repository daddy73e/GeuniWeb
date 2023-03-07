//
//  AppConfigure.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//
import Foundation

public class AppConfigure {

    public static let shared = AppConfigure()

    public let webBridgeMessageHandlerName = "geuniModule"
    /// 빌드환경
    public var enviromentType: EnvironmentType = .develop

    /// 애플 로그인 ID
    public var appleIDKey = "GEUNI_WEB_APPLE_LOGIN_ID"

    /// 카카오 로그인 AppKey
    public func kakaoAppKey() -> String? {
        guard let url = Bundle.main.url(forResource: "AppKey", withExtension: "plist") else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOf: url) else {
            return nil
        }
        return dictionary["kakaoAppAppID"] as? String
    }

    /// 기본 URL
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
}
