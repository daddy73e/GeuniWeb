//
//  KakaoLoginUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/03.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

public protocol KakaoLoginUseCaseProtocol {
    /// 초기화
    func initSDK()
    /// 로그인이 되어있는지 체크
    func checkLogin(completion: ((KakaoLoginResult) -> Void)?)
    /// 로그인 요청
    func requestLogin(completion: ((KakaoLoginOutput?) -> Void)?)
    /// 로그아웃 요청
    func requestLogout(completion: ((Error?) -> Void)?)
    /// 카카오톡 로그인
    func loginWithOpenUrl(url: URL)
    /// 카카오 플랫폼 안에서 앱과 사용자 카카오계정의 연결 상태를 해제
    func unlinkKakao(completion: ((Error?) -> Void)?)
}

public struct KakaoLoginInput {
}

public struct KakaoLoginOutput {
    var userInfo: UserInfo?
    var error: Error?
}

public enum KakaoLoginResult {
    case enableLogin
    case otherError(Error?)
    case needToLogin(Error?)
}

public class KakaoLoginUseCase: KakaoLoginUseCaseProtocol {

    public init() { }

    public func initSDK() {
        if let kakaoAppKey = AppConfigure.shared.kakaoAppKey() {
            KakaoSDK.initSDK(appKey: kakaoAppKey)
        }
    }

    public func checkLogin(completion: ((KakaoLoginResult) -> Void)?) {
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() {
                        completion?(.needToLogin(sdkError))
                    } else {
                        completion?(.otherError(error))
                    }
                } else {
                    completion?(.enableLogin)
                }
            }
        } else {
            completion?(.needToLogin(nil))
        }
    }

    public func requestLogin(completion: ((KakaoLoginOutput?) -> Void)?) {
        if UserApi.isKakaoTalkLoginAvailable() {
            /// 카카오톡 앱으로 로그인
            UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                if let error = error {
                    completion?(.init(userInfo: nil, error: error))
                } else {
                    print("kakao auth Token = \(String(describing: oauthToken))")
                    self?.requestKakakoUserInfo(completion: { userInfo in
                        completion?(.init(userInfo: userInfo, error: nil))
                    })
                }
            }
        } else {
            /// 카카오 계정 로그인 (웹브라우저)
            UserApi.shared.loginWithKakaoAccount { [weak self] (oauthToken, error) in
                if let error = error {
                    completion?(.init(userInfo: nil, error: error))
                } else {
                    print("kakao auth Token = \(String(describing: oauthToken))")
                    self?.requestKakakoUserInfo(completion: { userInfo in
                        completion?(.init(userInfo: userInfo, error: nil))
                    })
                }
            }
        }
    }

    public func requestLogout(completion: ((Error?) -> Void)?) {
        UserApi.shared.logout {(error) in
            if let error = error {
                completion?(error)
            } else {
                completion?(nil)
            }
        }
    }

    public func loginWithOpenUrl(url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            _ = AuthController.handleOpenUrl(url: url)
        }
    }

    public func unlinkKakao(completion: ((Error?) -> Void)?) {
        UserApi.shared.unlink {(error) in
            completion?(error)
        }
    }

    private func requestKakakoUserInfo(completion: ((UserInfo?) -> Void)?) {
        UserApi.shared.me { user, error in
            if error != nil {
                completion?(nil)
            } else {
                _ = user
                if let user = user {
                    completion?(.init(userID: "\(String(describing: user.id))"))
                }
            }
        }
    }
}
