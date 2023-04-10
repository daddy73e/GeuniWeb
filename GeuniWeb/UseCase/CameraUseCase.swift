//
//  CameraUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/10.
//

import Foundation
import AVFoundation

public protocol CameraUseCaseProtocol {
    func execute(input: CameraInput) -> CameraOutput
}

public struct CameraInput {
}

public struct CameraOutput {
}

public struct CameraPermissionOutput {
}

public class CameraUseCase: CameraUseCaseProtocol {
    public init() {
    }
    public func execute(input: CameraInput) -> CameraOutput {
        return CameraOutput()
    }
    
    public func permissionCheck(completion:((Bool)-> Void?)?) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion?(granted)
        }
    }
}
