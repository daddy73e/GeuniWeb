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
    init(fromRawValue: String) {
        self = SNSLoginType(rawValue: fromRawValue) ?? .none
    }
}

final class LoginManager: NSObject {

    public static let shared = LoginManager()

    private var appleLoginUseCase: AppleLoginUseCase?

    public func requestAppleLogin(completion: ((String?) -> Void)?) {
        self.appleLoginUseCase = AppleLoginUseCase()
        appleLoginUseCase?.requestLogin(completion: { output in
            if let userID = output?.user {
                completion?(userID)
            } else {
                completion?(nil)
            }
        })
    }
}
