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
    private let imagePath = "https://4.img-dpreview.com/files/p/E~TS590x0~articles/3925134721/0266554465.jpeg"
    private let originSplashImage = UIImage(named: "bororo")

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSplashImage()
    }

    private func loadSplashImage() {
        if let imageDictionary = UserDefaultsUseCase().read(
            input: .init(key: UserDefaultKey.splashImage.rawValue)
        ).value as? [String: Any] {
            if !imageDictionary.keys.contains(imagePath) {
                /// 새로운 이미지 path
                print("LOG 새로운 이미지 path")
                downloadImage(urlString: imagePath)
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
            downloadImage(urlString: imagePath)
        }
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

    func downloadImage(urlString: String) {
        guard let url = URL.init(string: urlString) else {
            print("LOG URL Error")
            self.imageView.image = self.originSplashImage
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
                        fileName: fileName,
                        fileStoreKey: urlString
                    )) { output in
                        self?.imageView.image = value.image
                    }
                }
            case .failure(let error):
                print("LOG Kingfisher image load Fail, url = \(urlString)")
                self?.imageView.image = self?.originSplashImage
            }
        }
    }
}

public extension Date {
    func getComponent(_ comp: Calendar.Component) -> Int {
        return Calendar.shared.component(comp, from: self)
    }

    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter.shared
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    func withoutTime() -> Date? {
        let components: DateComponents = Calendar.shared.dateComponents([.year, .month, .day], from: self)
        let start: Date? = Calendar.shared.date(from: components)
        return start
    }

    func getStartDayOfMonth() -> Date {
        let component = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: component) ?? Date()
    }

    func getNextMonth(of givenDate: Date = Date()) -> Date {
        return Calendar.current.date(
            byAdding: .month,
            value: 1,
            to: givenDate
        ) ?? Date()
    }

    func getPreviousMonth(of givenDate: Date = Date()) -> Date {
        return Calendar.current.date(
            byAdding: .month,
            value: -1,
            to: givenDate
        ) ?? Date()
    }

    var year: Int {
        return Calendar.shared.component(.year, from: self)
    }

    var month: Int {
        return Calendar.shared.component(.month, from: self)
    }

    var day: Int {
        return Calendar.shared.component(.day, from: self)
    }

    var hour: Int {
        return Calendar.shared.component(.hour, from: self)
    }

    var minute: Int {
        return Calendar.shared.component(.minute, from: self)
    }

    var second: Int {
        return Calendar.shared.component(.second, from: self)
    }
}

public extension Calendar {
    static var shared: Calendar = {
        return Calendar(identifier: .gregorian)
    }()
}

public extension DateFormatter {
    static var shared: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar.shared
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }()
}

extension Int {
    var byteSize: String {
        return ByteCountFormatter().string(fromByteCount: Int64(self))
    }
}
