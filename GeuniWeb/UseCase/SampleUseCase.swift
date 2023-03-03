//
//  SampleUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation

public protocol SampleUseCaseProtocol {
    func execute(input: SampleInput) -> SampleOutput
}

public struct SampleInput {
}

public struct SampleOutput {
}

public class SampleUseCase: SampleUseCaseProtocol {
    public init() {
    }
    public func execute(input: SampleInput) -> SampleOutput {
        return SampleOutput()
    }
}
