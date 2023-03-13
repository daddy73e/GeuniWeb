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
    /// 로그인 페이지 열기
    func openLoginPage()
    /// 로그인 요청
    func requestUserInfo(completion: ((PaycoLoginOutput?) -> Void)?)
    /// 로그아웃 요청
    func requestLogout(completion: ((Error?) -> Void)?)
}

public struct PaycoLoginInput {
}

public struct PaycoLoginOutput {
}

public class PaycoLoginUseCase: NSObject, PaycoLoginUseCaseProtocol {
    
    public var accessToken = ""
    
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
    
    public func openLoginPage() {
        PIDThirdPartyAuth.openLoginView()
    }
    
    public func requestUserInfo(completion: ((PaycoLoginOutput?) -> Void)?) {
        PIDThirdPartyAuth.memberProfile(withAccessToken: self.accessToken) { profile, error in
            print(profile)
        }
    }
    
    public func requestLogout(completion: ((Error?) -> Void)?) {

    }
}

extension PaycoLoginUseCase: PIDThirdPartyAuthDelegate {
    public func didSuccessLogin(_ userInfo: [AnyHashable : Any]!) {
        
    }
    
    public func didFailLogin(_ error: PIDError!) {
        
    }
    
    public func didSuccessLogout() {
        
    }
    
    public func didFailLogout(_ error: PIDError!) {
        
    }
}
