//
//  PaycoLoginUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/13.
//

import Foundation

public protocol PaycoLoginUseCaseProtocol {
    /// 초기화
    func initSDK()
    /// URL을 통해 열기
    func loginWithOpenUrl(url: URL)
    /// 로그인 요청
    func requestLogin(completion: ((PaycoLoginOutput?) -> Void)?)
    /// 로그아웃 요청
    func requestLogout(completion: ((Error?) -> Void)?)
}

public struct PaycoLoginInput {
}

public struct PaycoLoginOutput {
    var userInfo: UserInfo?
    var error: Error?

    init(
        userInfo: UserInfo? = nil,
        error: Error? = nil
    ) {
        self.userInfo = userInfo
        self.error = error
    }
}

public class PaycoLoginUseCase: NSObject, PaycoLoginUseCaseProtocol {

    private var loginCompletion: ((PaycoLoginOutput?) -> Void)?
    private var logoutCompletion: ((Error?) -> Void)?

    public override init() { }

    public func initSDK() {
        let config = PIDAuthThirdConfig.init()
        config.clientID = AppConfigure.shared.paycoClientID() ?? ""
        config.secret = AppConfigure.shared.paycoClientSecret() ?? ""
        config.serviceName = AppConfigure.shared.serviceName
        config.serviceCode = "FRIENDS"
        config.serverType = PIDServerTypeReal
        config.delegate = self
        PIDThirdPartyAuth.setup(config)
    }
    public func loginWithOpenUrl(url: URL) {
        PIDThirdPartyAuth.handleOpen(url)
    }

    public func requestLogin(completion: ((PaycoLoginOutput?) -> Void)?) {
        self.loginCompletion = completion
        PIDThirdPartyAuth.openLoginView()
    }

    public func requestLogout(completion: ((Error?) -> Void)?) {
        self.logoutCompletion = completion
        if let accessToken = UserDefaultUseCase().read(
            input: .init(key: UserDefaultKey.paycoAccessToekn.rawValue)
        ).value as? String {
            PIDThirdPartyAuth.logout(accessToken)
        }
    }
}

extension PaycoLoginUseCase: PIDThirdPartyAuthDelegate {
    public func didSuccessLogin(_ userInfo: [AnyHashable: Any]!) {
        guard let dicData = userInfo as? [String: Any] else {
            self.loginCompletion?(.init())
            return
        }

        let accessToken = (dicData["access_token"] as? String) ?? ""
        let serviceExtra = (dicData["serviceExtra"] as? [String: Any]) ?? [:]
        let refreshToken = (serviceExtra["refreshToken"] as? String) ?? ""

        UserDefaultUseCase().write(input: .init(
            key: UserDefaultKey.paycoAccessToekn.rawValue,
            value: accessToken
        ))
        UserDefaultUseCase().write(input: .init(
            key: UserDefaultKey.paycoRefreshToekn.rawValue,
            value: refreshToken
        ))

        PIDThirdPartyAuth.memberProfile(withAccessToken: accessToken) { profile, _ in
            guard let userID = profile?.idNo else {
                self.loginCompletion?(.init())
                return
            }

            let userInfo = UserInfo(userID: userID)
            self.loginCompletion?(.init(userInfo: userInfo))
        }
    }

    public func didFailLogin(_ error: PIDError!) {
        self.loginCompletion?(.init(error: error))
    }

    public func didSuccessLogout() {
        UserDefaultUseCase().delete(input: .init(key: UserDefaultKey.paycoAccessToekn.rawValue))
        UserDefaultUseCase().delete(input: .init(key: UserDefaultKey.paycoRefreshToekn.rawValue))
        self.logoutCompletion?(nil)
    }

    public func didFailLogout(_ error: PIDError!) {
        self.logoutCompletion?(error)
    }
}
