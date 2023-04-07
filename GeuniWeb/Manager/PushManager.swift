//
//  PushManager.swift
//  fnb
//
//  Created by 60157085 on 2023/04/05.
//

import Foundation

final class PushManager {

    public static let shared = PushManager()

    private func observeNotificationStatus() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkNotificationSetting),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }

    @objc private func checkNotificationSetting() {
        UNUserNotificationCenter.current().getNotificationSettings { permission in
            Task { @MainActor in
                switch permission.authorizationStatus {
                case .authorized:
                    UIApplication.shared.registerForRemoteNotifications()
                case .denied:
                    UIApplication.shared.unregisterForRemoteNotifications()
                case .notDetermined:
                    UIApplication.shared.unregisterForRemoteNotifications()
                case .provisional:
                    UIApplication.shared.unregisterForRemoteNotifications()
                case .ephemeral:
                    print("푸시 설정이 App Clip에 대해서만 부분적으로 동의한 경우")
                @unknown default:
                    print("Unknow Status")
                }
            }
        }
    }

    public func updatePushNotificationStatus(isOn: Bool, completion: ((Bool) -> Void)? = nil) {
        if isOn {
            if UserDefaultsUseCase().read(
                input: .init(key: UserDefaultKey.pushDeviceToken.rawValue)
            ).value != nil {
                completion?(true)
            } else {
                completion?(false)
            }
        } else {
            UIApplication.shared.unregisterForRemoteNotifications()
            completion?(true)
        }
    }

    public func registerDeviceToken(deviceToken: Data) {
        let deviceTokenString = deviceToken.map { String(format: "%02x", $0) }.joined()
        UserDefaultsUseCase().write(
            input: .init(
                key: UserDefaultKey.pushDeviceToken.rawValue,
                value: deviceTokenString
            )
        )
    }

    public func registerForRemoteNotifications(delegate: UNUserNotificationCenterDelegate) {
        // 1. 푸시 center (유저에게 권한 요청 용도)
        let center = UNUserNotificationCenter.current()
        center.delegate = delegate // push처리에 대한 delegate - UNUserNotificationCenterDelegate
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { (granted, _) in
            guard granted else {
                return
            }
            DispatchQueue.main.async {
                // 2. APNs에 디바이스 토큰 등록
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        self.observeNotificationStatus()
    }
}
