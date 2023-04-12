//
//  WebMainViewController+Notification.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/07.
//

import UIKit

extension WebMainViewController {
    func addNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(navigateLoginPage(_:)),
            name: Notification.Name.logout,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil
        )
        NotificationCenter.default.addObserver(
            self, selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateNetworkSataus(notification:)),
            name: Notification.Name.changeNetworkStatus,
            object: nil
        )
    }

    func removeNotification() {
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name.logout,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )

        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name.changeNetworkStatus,
            object: nil
        )
    }

    @objc func updateNetworkSataus(notification: Notification) {
        if let networkStatus = notification.object as? NetworkStatus {
            if networkStatus == .notConnected {
                Task { @MainActor in
                    Toast.shared.show(
                        option: .init(
                            backgroundView: self.view,
                            message: "네트워크 연결확인이 필요합니다.",
                            isFixed: true
                        )
                    )
                }
            } else {
                if Toast.shared.isAnimating {
                    return
                }
                Toast.shared.hide(
                    animate: true,
                    hideDelay: 0.0,
                    completion: nil
                )
            }
        }
    }
}
