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
    private let imagePath = "https://cdn.pixabay.com/photo/2017/09/25/13/12/puppy-2785074__480.jpg"
    private let originSplashImage = UIImage(named: "bororo")

    public var navigateDuplicateCallFlag = false // 네트워크 전환, 중복호출 방지용 flag

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSplashImage()
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
        SNSLoginManager.shared.checkLogin { _ in
            //            if !isAutoLogin {
            //                /// login화면
            //                return
            //            }
            /// isAutoLogin이 true일 경우, 메인
            print("")
            Task { @MainActor in
                self.dismiss(animated: false) {
                    if !self.navigateDuplicateCallFlag {
                        self.navigateDuplicateCallFlag = true

                        let navigationController = UINavigationController(rootViewController: WebMainViewController())
                        navigationController.modalPresentationStyle = .fullScreen
                        Router.shared.navigate(fromVC: self, toVC: navigationController, animated: false)
                    }
                }
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

    private func loadSplashImage() {
        if let imageDictionary = UserDefaultsUseCase().read(
            input: .init(
                key: UserDefaultKey.splashImage.rawValue
            )
        ).value as? [String: Any] {
            if !imageDictionary.keys.contains(imagePath) {
                /// 새로운 이미지 path
                print("LOG 새로운 이미지 path")
                downloadImage(urlString: imagePath) { [weak self] image in
                    self?.imageView.image = image
                }
                return
            }
            /// 저장된 이미지 불러오기
            guard let imageName = imageDictionary[imagePath] as? String else { return }
            FileManagerUseCase().read(input: .init(fileName: imageName)) { [weak self] output in
                guard let data = output.data else {
                    return
                }
                if let splashImage = UIImage(data: data) {
                    Task { @MainActor in
                        self?.imageView.image = splashImage
                    }
                } else {
                    /// 불러오기 실패, 기본 이미지
                    print("LOG FileLoad fail")
                    self?.imageView.image = self?.originSplashImage
                }
            }
        } else {
            /// 이미지 없음 새로 불러옴
            print("LOG no image, reload")
            downloadImage(urlString: imagePath) { [weak self] image in
                self?.imageView.image = image
            }
        }
    }

    private func downloadImage(urlString: String, completion: ((UIImage?) -> Void)?) {
        guard let url = URL.init(string: urlString) else {
            completion?(self.originSplashImage)
            return
        }

        let resource = ImageResource(downloadURL: url)
        KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) {[weak self] result in
            switch result {
            case .success(let value):
                if let imageData = value.image.jpegData(compressionQuality: 1.0) {
                    let fileName = "geuniWeb_\(Date().toString())"
                    FileManagerUseCase().write(input: .init(
                        data: imageData,
                        fileName: fileName
                    )) { _ in
                        UserDefaultsUseCase().write(
                            input: .init(
                                key: UserDefaultKey.splashImage.rawValue,
                                value: [urlString: fileName]
                            )
                        )
                        completion?(value.image)
                    }
                }
            case .failure:
                print("LOG Kingfisher image load Fail, url = \(urlString)")
                completion?(self?.originSplashImage)
            }
        }
    }
}
