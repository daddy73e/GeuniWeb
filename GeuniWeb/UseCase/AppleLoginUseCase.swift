//
//  AppleLoginUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import Foundation
import AuthenticationServices

public struct AppleLoginInput {

}
public struct AppleLoginOutput {
}

public protocol AppleLoginUseCaseProtocol {
    func execute(input: AppleLoginInput) -> AppleLoginOutput
}

public class AppleLoginUseCase: AppleLoginUseCaseProtocol {

    public func execute(input: AppleLoginInput) -> AppleLoginOutput {
        return AppleLoginOutput()
    }
}
