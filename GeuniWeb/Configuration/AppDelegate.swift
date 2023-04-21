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
            SNSLoginManager.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
            NetworkStatusManager.shared.startMonitoring(delegate: self)
            LocationManager.shared.setupLocationManager()
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

extension AppDelegate: NetworkStatusDelegate {
    func observeNetworkStatus(status: NetworkStatus) {
        NotificationCenter.default.post(name: .changeNetworkStatus, object: status)
    }
}
