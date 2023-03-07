//
//  SplashViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        SNSLoginManager.shared.checkLogin { isAutoLogin in
            print(isAutoLogin)
            /// isAutoLogin이 true일 경우, 메인
            /// false일 경우, login화면
            Task { @MainActor in
                let navigationController = UINavigationController(rootViewController: WebMainViewController())
                navigationController.modalPresentationStyle = .fullScreen
                Router.shared.navigate(fromVC: self, toVC: navigationController, animated: false)
            }
        }
    }
}
