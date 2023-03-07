//
//  FacebookLoginUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/03/07.
//

import Foundation
import FacebookCore
import FacebookLogin

public protocol FacebookLoginUseCaseProtocol {
    /// 초기화
    func initSDK(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    /// URL을 통해 열기
    func loginWithOpenUrl(url: URL)
    /// 로그인이 되어있는지 체크
    func checkLogin() -> Bool
    /// 로그인 요청 (뷰컨트롤러에서 호출)
    func requestLogin(viewController: UIViewController, completion: ((FacebookLoginOutput?) -> Void)?)
    /// 로그아웃 요청
    func requestLogout()
}

public struct FacebookLoginInput {
}

public struct FacebookLoginOutput {
}

public class FacebookLoginUseCase: FacebookLoginUseCaseProtocol {
    public init() {
    }

    public func initSDK(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: launchOptions
        )
    }

    public func loginWithOpenUrl(url: URL) {
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

    public func checkLogin() -> Bool {
        if let token = AccessToken.current,
           !token.isExpired {
            return true
        } else {
            return false
        }
    }

    public func requestLogin(
        viewController: UIViewController,
        completion: ((FacebookLoginOutput?) -> Void)?
    ) {
        let facebookLoginManager = LoginManager()
        facebookLoginManager.logIn(permissions: ["public_profile"], from: viewController) { result, error in
            if let error = error {
                print("Encountered Erorr: \(error)")
            } else if let result = result, result.isCancelled {
                print("Cancelled")
            } else {
                print("Logged In")
            }
        }
    }

    public func requestLogout() {
        let facebookLoginManager = LoginManager()
        facebookLoginManager.logOut()
    }
}
