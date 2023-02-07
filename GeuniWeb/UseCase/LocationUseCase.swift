//
//  LocationUseCase.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import Foundation
import CoreLocation
import UIKit

public enum LocationPermission {
    case none
    case access /// 사용가능
    case denied /// 거부됨
    case disabled /// 사용할 수 없음
}

public struct LocationInput {
    public let delegate: CLLocationManagerDelegate
    public init(delegate: CLLocationManagerDelegate) {
        self.delegate = delegate
    }
}

public struct LocationPermissionOutput {
    let permission: LocationPermission
    init(permission: LocationPermission) {
        self.permission = permission
    }
}

public protocol LocationUseCaseProtocol {
    func request(input: LocationInput)
    func permissionCheck() -> LocationPermissionOutput
}

public class LocationUseCase: LocationUseCaseProtocol {
    var locationManager: CLLocationManager?
    public init() { }
    public func request(input: LocationInput) {
        locationManager = CLLocationManager()
        locationManager?.delegate = input.delegate
        locationManager?.requestAlwaysAuthorization()
    }
    public func permissionCheck() -> LocationPermissionOutput {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, CLAuthorizationStatus.denied:
                return .init(permission: LocationPermission.denied)
            case .authorizedAlways, .authorizedWhenInUse:
                return .init(permission: LocationPermission.access)
            @unknown default:
                return .init(permission: LocationPermission.none)
            }
        } else {
            return .init(permission: LocationPermission.disabled)
        }

    }
}
