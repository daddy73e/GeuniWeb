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
//    private let imagePath = "https://media.istockphoto.com/id/1161352480/vector/sample-sign-sample-square-speech-bubble-sample.jpg?s=612x612&w=0&k=20&c=qZ480B32q1qGLxoTZEaXcxDB4BMCMDGAGnDQ0hEJ_I8="
//    private let imagePath = "https://cdn.crowdpic.net/list-thumb/thumb_l_CDD94CBD46425E4EDBD18A7A17C199E7.jpg"
    private let imagePath = "https://cdn.pixabay.com/photo/2017/09/25/13/12/puppy-2785074__480.jpg"
    private let originSplashImage = UIImage(named: "bororo")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSplashImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// Splash 이미지 체크용
//        TimerManager(timeInterval: 1, finishTime: 3).startTimer(tickAction: nil) {
//            SNSLoginManager.shared.checkLogin { isAutoLogin in
//                print(isAutoLogin)
//                /// isAutoLogin이 true일 경우, 메인
//                /// false일 경우, login화면
//                Task { @MainActor in
//                    self.dismiss(animated: false) {
//                        let navigationController = UINavigationController(rootViewController: WebMainViewController())
//                        navigationController.modalPresentationStyle = .fullScreen
//                        Router.shared.navigate(fromVC: self, toVC: navigationController, animated: false)
//                    }
//                }
//            }
//        }
        
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
