//
//  AppDelegate.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit
import FacebookCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

            AppleLoginUseCase().checkLogin { isLoginSuccess in
                if isLoginSuccess {
                    SNSLoginManager.shared.updateSNSLoginType(type: .apple)
                    print("로그인 이후 페이지로 이동")
                } else {
                    print("로그인 페이지로 이동")
                }
            }

            KakaoLoginUseCase().initSDK()
            KakaoLoginUseCase().checkLogin { result in
                switch result {
                case .enableLogin:
                    SNSLoginManager.shared.updateSNSLoginType(type: .kakao)
                    print("로그인 이후 페이지로 이동")
                case .otherError(let error):
                    print("로그인 페이지로 이동 \(String(describing: error))")
                case .needToLogin(let error):
                    print("로그인 페이지로 이동 \(String(describing: error))")
                }
            }

            FacebookLoginUseCase().initSDK(launchOptions: launchOptions)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        AppConfigure.shared.enviromentType = .develop
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
