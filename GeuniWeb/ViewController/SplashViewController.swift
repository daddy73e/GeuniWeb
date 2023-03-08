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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SNSLoginManager.shared.checkLogin { isAutoLogin in
            print(isAutoLogin)
            /// isAutoLogin이 true일 경우, 메인
            /// false일 경우, login화면
            Task { @MainActor in
                self.dismiss(animated: false) {
                    let navigationController = UINavigationController(rootViewController: WebMainViewController())
                    navigationController.modalPresentationStyle = .fullScreen
                    Router.shared.navigate(fromVC: self, toVC: navigationController, animated: false)
                }
            }
        }
    }
}
