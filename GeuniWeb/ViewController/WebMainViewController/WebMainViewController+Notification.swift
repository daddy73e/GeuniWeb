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
    }
}
