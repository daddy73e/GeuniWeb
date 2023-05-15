//
//  AppConfigure.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//
import Foundation

public class AppConfigure {

    public static let shared = AppConfigure()

    public let serviceName = "GeuniWeb"

    public let webBridgeMessageHandlerName = "geuniModule"
    /// 빌드환경
    public var enviromentType: EnvironmentType = .develop
    /// 스크린 모드
    public var screenMode: ScreenType = .safeArea

    /// 애플 로그인 ID
    public var appleIDKey = UserDefaultKey.appleIDKey
    /// 페이코 accessTokeyID
    public var paycoAccessToekn = UserDefaultKey.paycoAccessToekn

    public var baseUrl = Bundle.main.url(forResource: "test", withExtension: "html")

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

    /// 페이코 로그인 ClientID
    public func paycoClientID() -> String? {
        guard let url = Bundle.main.url(forResource: "AppKey", withExtension: "plist") else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOf: url) else {
            return nil
        }
        return dictionary["paycoClientID"] as? String
    }

    /// 페이코 로그인 Secret
    public func paycoClientSecret() -> String? {
        guard let url = Bundle.main.url(forResource: "AppKey", withExtension: "plist") else {
            return nil
        }

        guard let dictionary = NSDictionary(contentsOf: url) else {
            return nil
        }
        return dictionary["paycoClientSecret"] as? String
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
    
    public func deviceId() -> String {
        return UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
}
