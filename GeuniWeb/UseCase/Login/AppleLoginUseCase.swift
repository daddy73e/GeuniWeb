//
//  AppleLoginUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import Foundation
import AuthenticationServices

public protocol AppleLoginUseCaseProtocol {
    /// 로그인이 되어있는지 체크
    func checkLogin(appleID: String, completion: ((Bool) -> Void)?)
    /// 로그인 요청
    func requestLogin(completion: ((AppleLoginOutput?) -> Void)?)
}

public struct AppleLoginOutput {
    var idToken: String?
    var authCode: String?
    var user: String?
    init(
        idToken: String?,
        authCode: String?,
        user: String?
    ) {
        self.idToken = idToken
        self.authCode = authCode
        self.user = user
    }
}

public class AppleLoginUseCase: NSObject, AppleLoginUseCaseProtocol {
    var completion: ((AppleLoginOutput?) -> Void)?

    public func checkLogin(appleID: String, completion: ((Bool) -> Void)?) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: appleID) { (credentialState, _) in
            switch credentialState {
            case .authorized:
                completion?(true)
            case .revoked, .notFound:
                completion?(false)
            default:
                completion?(false)
            }
        }
    }

    public func requestLogin(completion: ((AppleLoginOutput?) -> Void)?) {
        self.completion = completion
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
}

extension AppleLoginUseCase: ASAuthorizationControllerDelegate {

    public func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let idToken = credential.identityToken!
            let token = String(data: idToken, encoding: .utf8)
            guard let code = credential.authorizationCode else { return }
            let authCode = String(data: code, encoding: .utf8)
            let user = credential.user
            completion?(.init(idToken: token, authCode: authCode, user: user))
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion?(nil)
    }
}
