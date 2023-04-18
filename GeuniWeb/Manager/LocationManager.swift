//
//  LocationManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/18.
//
import Foundation
import CoreLocation
import Combine

public enum LocationStatus {
    /// 이용가능
    case available
    /// 결정안됨
    case notDetermined
    /// 시스템 위치공유 제안
    case locationSystemDenied
}

public protocol LocationManagerDelegate: AnyObject {
    func loactionChangeAuthorization(status: LocationStatus)
}

public class LocationManager: NSObject, CLLocationManagerDelegate {
    public static let shared = LocationManager()
    private let manager = CLLocationManager()
    private let notificationCenter = NotificationCenter.default

    public weak var delegate: LocationManagerDelegate?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    private override init() { }

    func checkLocationService() {
        setupLocationManager()
        checkLocationManagerAuthorization()
    }

    private func setupLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    private func checkLocationManagerAuthorization() {
        if #available(iOS 14.0, *) {
            authorizationStatus = manager.authorizationStatus
        }

        switch authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            print("::: -> Location: denied")
        default:
            break
        }
    }

    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationManagerAuthorization()
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                delegate?.loactionChangeAuthorization(status: .locationSystemDenied)
            case .authorizedAlways, .authorizedWhenInUse:
                delegate?.loactionChangeAuthorization(status: .available)
            case .denied, .restricted:
                delegate?.loactionChangeAuthorization(status: .notDetermined)
            default:
                break
            }

        }
    }

    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
    }
}
