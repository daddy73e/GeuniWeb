//
//  SNSLoginManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//

import Foundation

import UIKit

public enum SNSLoginType: String {
    case none
    case apple
    case kakao
    case facebook
    case payco
    init(fromRawValue: String) {
        self = SNSLoginType(rawValue: fromRawValue) ?? .none
    }
}

protocol SNSLoginManagerProtocol: AnyObject {
    /// AppDelegate에서 didFinishLaunchingWithOptions 호출시 호출
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    )
    /// 로그인 유무 체크, 스플래시에서 호출
    func checkLogin(completion: ((Bool) -> Void)?)
    /// 애플 로그인 요청
    func requestAppleLogin(completion: ((UserInfo?) -> Void)?)
    /// 카카오 로그인 요청
    func requestKakaoLogin(completion: ((UserInfo?) -> Void)?)
    /// 페이스북 로그인 요청
    func requestFacebookLogin(viewController: UIViewController, completion: ((UserInfo?) -> Void)?)
    /// 페이코 로그인 요청
    func requestPaycoLogin(completion: ((UserInfo?) -> Void)?)
    /// 로그아웃 요청
    func requestLogout(completion: ((Error?) -> Void)?)
}

final class SNSLoginManager: SNSLoginManagerProtocol {

    public static let shared = SNSLoginManager()
    private var appleLoginUseCase = AppleLoginUseCase()
    private var kakaoLoginUseCase =  KakaoLoginUseCase()
    private var facebookLoginUseCase = FacebookLoginUseCase()
    private var paycoLoginUseCase = PaycoLoginUseCase()

    private let userDefaultKey = UserDefaultKey.snsLoginType.rawValue

    public func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        self.kakaoLoginUseCase.initSDK()
        self.facebookLoginUseCase.initSDK(launchOptions: launchOptions)
        self.paycoLoginUseCase.initSDK()
    }

    public func checkLogin(completion: ((Bool) -> Void)?) {
        let loginType = savedLoginType()
        switch loginType {
        case .apple:
            self.appleLoginUseCase.checkLogin { isLoginSuccess in
                if isLoginSuccess {
                    SNSLoginManager.shared.updateSNSLoginType(type: .apple)
                    completion?(true)
                } else {
                    completion?(false)
                }
            }
        case .kakao:
            self.kakaoLoginUseCase.checkLogin { result in
                switch result {
                case .enableLogin:
                    SNSLoginManager.shared.updateSNSLoginType(type: .kakao)
                    completion?(true)
                case .otherError:
                    completion?(false)
                case .needToLogin:
                    completion?(false)
                }
            }
        case .facebook:
            completion?(self.facebookLoginUseCase.checkLogin())
        default:
            completion?(false)
        }
    }

    public func requestAppleLogin(completion: ((UserInfo?) -> Void)?) {
        appleLoginUseCase.requestLogin(completion: { [weak self] output in
            if let userID = output?.user {
                self?.updateSNSLoginType(type: .apple)
                completion?(.init(userID: userID))
            } else {
                completion?(nil)
            }
        })
    }

    public func requestKakaoLogin(completion: ((UserInfo?) -> Void)?) {
        self.kakaoLoginUseCase.requestLogin { [weak self] output in
            if let userInfo = output?.userInfo {
                self?.updateSNSLoginType(type: .kakao)
                completion?(userInfo)
            } else {
                completion?(nil)
            }
        }
    }

    public func requestFacebookLogin(
        viewController: UIViewController,
        completion: ((UserInfo?) -> Void)?
    ) {
        self.facebookLoginUseCase.requestLogin(
            viewController: viewController,
            completion: { [weak self] output in
                guard let userInfo = output?.userInfo else {
                    completion?(nil)
                    return
                }
                print(userInfo)
                self?.updateSNSLoginType(type: .facebook)
                completion?(userInfo)
            }
        )
    }

    public func requestPaycoLogin(completion: ((UserInfo?) -> Void)?) {
        self.paycoLoginUseCase.requestLogin { [weak self] output in
            guard let userInfo = output?.userInfo else {
                completion?(nil)
                return
            }
            print(userInfo)
            self?.updateSNSLoginType(type: .payco)
            completion?(userInfo)

        }
    }

    public func requestLogout(completion: ((Error?) -> Void)?) {
        let loginType = savedLoginType()

        switch loginType {
        case .apple:
            let keyCainUseCase = KeychainUseCase()
            keyCainUseCase.delete(input: .init(key: UserDefaultKey.appleIDKey.rawValue))
            self.updateSNSLoginType(type: .none)
            completion?(nil)
        case .kakao:
            /// SNS Kakao Logout
            KakaoLoginUseCase().requestLogout { error in
                if error != nil {
                    print("카카오톡 로그아웃 성공")
                }
                self.updateSNSLoginType(type: .none)
                completion?(error)
            }
        case .facebook:
            FacebookLoginUseCase().requestLogout()
            self.updateSNSLoginType(type: .none)
            completion?(nil)
        case .payco:
            PaycoLoginUseCase().requestLogout { error in
                if error != nil {
                    self.updateSNSLoginType(type: .none)
                }
                completion?(nil)
            }
        default:
            completion?(nil)
        }
    }

    func loginWithOpenUrl(url: URL) {
        KakaoLoginUseCase().loginWithOpenUrl(url: url)
        FacebookLoginUseCase().loginWithOpenUrl(url: url)
        PaycoLoginUseCase().loginWithOpenUrl(url: url)
    }
}

private extension SNSLoginManager {
    func updateSNSLoginType(type: SNSLoginType) {
        UserDefaultUseCase().write(input: .init(key: self.userDefaultKey, value: type.rawValue))
    }

    func savedLoginType() -> SNSLoginType {
        guard let strLoginType = UserDefaultUseCase().read(
            input: .init(key: self.userDefaultKey)
        ).value as? String else {
            return .none
        }
        return SNSLoginType(fromRawValue: strLoginType)
    }
}
