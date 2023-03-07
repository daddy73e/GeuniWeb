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
    init(fromRawValue: String) {
        self = SNSLoginType(rawValue: fromRawValue) ?? .none
    }
}

final class SNSLoginManager: NSObject {

    public static let shared = SNSLoginManager()

    private var appleLoginUseCase: AppleLoginUseCase?
    private var kakaoLoginUseCase: KakaoLoginUseCase?
    private var facebookLoginUseCase: FacebookLoginUseCase?

    private var loginType: SNSLoginType = .none

    public func requestAppleLogin(completion: ((UserInfo?) -> Void)?) {
        self.appleLoginUseCase = AppleLoginUseCase()
        appleLoginUseCase?.requestLogin(completion: { [weak self] output in
            if let userID = output?.user {
                self?.loginType = .apple
                completion?(.init(userID: userID))
            } else {
                completion?(nil)
            }
        })
    }

    public func requestKakaoLogin(completion: ((UserInfo?) -> Void)?) {
        self.kakaoLoginUseCase = KakaoLoginUseCase()
        self.kakaoLoginUseCase?.requestLogin { [weak self] output in
            if let userInfo = output?.userInfo {
                self?.loginType = .kakao
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
        self.facebookLoginUseCase = FacebookLoginUseCase()
        self.facebookLoginUseCase?.requestLogin(
            viewController: viewController,
            completion: { output in
                completion?(nil)
        })
    }

    public func requestLogout(completion: (() -> Void)?) {
        switch loginType {
        case .apple:
            let keyCainUseCase = KeychainUseCase()
            keyCainUseCase.delete(input: .init(key: AppConfigure.shared.appleIDKey))
            loginType = .none
            completion?()
        case .kakao:
            /// SNS Kakao Logout
            KakaoLoginUseCase().requestLogout { error in
                if error != nil {
                    print("카카오톡 로그아웃 성공")
                }
                self.loginType = .none
                completion?()
            }
        case .facebook:
            FacebookLoginUseCase().requestLogout()
            loginType = .none
            completion?()
        default:
            completion?()
        }
    }

    public func updateSNSLoginType(type: SNSLoginType) {
        self.loginType = type
    }
}
