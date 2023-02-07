//
//  UIViewController+.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation
import UIKit

extension UIViewController {
    /* 세팅창으로 이동 */
    func routeSettingPage() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}
