//
//  CameraUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/10.
//

import Foundation
import UIKit
import AVFoundation
import Photos

public protocol CameraUseCaseProtocol {
    func checkPermission(completion: ((CameraPermissionOutput) -> Void?)?)
}

public enum CameraPermissionOutput {
    case enableCameraAlbum
    case disableCamera
    case disableAlbum
}

public class CameraUseCase: CameraUseCaseProtocol {
    public init() { }

    public func checkPermission(completion: ((CameraPermissionOutput) -> Void?)?) {
        self.checkCameraPermission { isEnableCamera in
            if isEnableCamera {
                self.checkAlbumPermission { isEnableAlbum in
                    completion?(isEnableAlbum ? .enableCameraAlbum : .disableAlbum)
                }
            } else {
                completion?(.disableCamera)
            }
        }
    }

    private func checkCameraPermission(completion: ((Bool) -> Void?)?) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            completion?(granted)
        }
    }

    private func checkAlbumPermission(completion: ((Bool) -> Void?)?) {
        PHPhotoLibrary.requestAuthorization({ status in
            switch status {
            case .authorized:
                completion?(true)
            default:
                completion?(false)
            }
        })
    }
}
