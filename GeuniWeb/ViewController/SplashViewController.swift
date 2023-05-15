//
//  SplashViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import UIKit
import Kingfisher

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    private let placeHolder = UIImage(named: "bororo")

    public var navigateDuplicateCallFlag = false // 네트워크 전환, 중복호출 방지용 flag

    override func viewDidLoad() {
        super.viewDidLoad()
        ImageDownloadManager.shared.loadSplashImage { [weak self] imageData in
            guard let savedImage = imageData else {
                self?.imageView.image = self?.placeHolder
                return
            }
            Task { @MainActor in
                if let savedImage = UIImage(data: savedImage) {
                    self?.imageView.image = savedImage
                } else {
                    self?.imageView.image = self?.placeHolder
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateNetworkSataus(notification:)),
            name: Notification.Name.changeNetworkStatus,
            object: nil
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigateDuplicateCallFlag = false
        checkNetwork()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: Notification.Name.changeNetworkStatus,
            object: nil
        )
    }

    private func checkNetwork() {
        if NetworkStatusManager.shared.networkStatus == .notConnected {
            Toast.shared.show(
                option: .init(
                    backgroundView: self.view,
                    message: "네트워크 연결확인이 필요합니다.",
                    isFixed: true
                )
            )
            return
        } else {
            Toast.shared.hide(animate: false)
            self.checkLogin()
        }
    }

    private func checkLogin() {
        
        TimerManager(timeInterval: 1.0, finishTime: 2.0).startTimer(tickAction: nil) {
            SNSLoginManager.shared.checkLogin { [weak self] _ in
                //            if !isAutoLogin {
                //                /// login화면
                //                return
                //            }
                /// isAutoLogin이 true일 경우, 메인
                print("")
                Task { @MainActor in
                    self?.routeToMain()
                    
                }
            }
        }
    }
    
    private func routeToMain() {
        self.dismiss(animated: false) {
            if !self.navigateDuplicateCallFlag {
                self.navigateDuplicateCallFlag = true
                
                let navigationController = BaseNavigationViewController(
                    rootViewController: WebMainViewController()
                )
                navigationController.modalPresentationStyle = .fullScreen
                Router.shared.navigate(fromVC: self, toVC: navigationController, animated: false)
            }
        }
    }

    @objc func updateNetworkSataus(notification: Notification) {
        if let networkStatus = notification.object as? NetworkStatus {
            if networkStatus != .notConnected {
                checkNetwork()
            }
        }
    }
}
