//
//  AppDelegate.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit
import AuthenticationServices

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let keyCainUseCase = KeychainUseCase()
            if let appleLoginID = keyCainUseCase.read(input: .init(key: AppConfigure.shared.appleIDKey)) {
                appleIDProvider.getCredentialState(forUserID: appleLoginID) { (credentialState, error) in
                    switch credentialState {
                    case .authorized:
                        break // The Apple ID credential is valid.
                    case .revoked, .notFound:
                        
                        break
                    default:
                        break
                    }
                }
                return true
            }
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
