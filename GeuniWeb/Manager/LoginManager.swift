//
//  LoginManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//

import Foundation

public enum SNSLoginType: String {
    case none
    case apple
    case kakao
    init(fromRawValue: String) {
        self = SNSLoginType(rawValue: fromRawValue) ?? .none
    }
}

final class LoginManager: NSObject {

    public static let shared = LoginManager()

    private var appleLoginUseCase: AppleLoginUseCase?
    private var kakaoLoginUseCase: KakaoLoginUseCase?

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

    public func requestLogout(completion: (() -> Void)?) {
        switch loginType {
        case .none:
            completion?()
        case .apple:
            let keyCainUseCase = KeychainUseCase()
            keyCainUseCase.delete(input: .init(key: AppConfigure.shared.appleIDKey))
            completion?()
        case .kakao:
            /// SNS Kakao Logout
            KakaoLoginUseCase().requestLogout { error in
                if error != nil {
                    print("카카오톡 로그아웃 성공")
                }
                completion?()
            }
        }
    }

    public func updateSNSLoginType(type: SNSLoginType) {
        self.loginType = type
    }
}
