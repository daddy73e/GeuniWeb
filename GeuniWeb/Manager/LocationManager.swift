//
//  LocationManager.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/18.
//
import Foundation
import CoreLocation
import Combine

public struct Location {
    var latitude: Double
    var longitude: Double
}

public enum LocationStatus {
    /// 이용가능
    case available(Location)
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
    private var completion: ((LocationStatus) -> Void)?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined

    private override init() { }

    public func setupLocationManager() {
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    public func checkLocationManagerAuthorization(
        completion: ((LocationStatus) -> Void)?
    ) {
        if #available(iOS 14.0, *) {
            authorizationStatus = manager.authorizationStatus
        }
        self.completion = completion
        switch authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .denied, .restricted:
            completion?(.locationSystemDenied)
        default:
            break
        }
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didChangeAuthorization status: CLAuthorizationStatus
    ) {
        if #available(iOS 14.0, *) {
            switch manager.authorizationStatus {
            case .notDetermined:
                completion?(.locationSystemDenied)
            case .authorizedAlways, .authorizedWhenInUse:
                manager.startUpdatingLocation()
            case .denied, .restricted:
                completion?(.notDetermined)
            default:
                break
            }
        }
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        manager.stopUpdatingLocation()
    }

    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        manager.stopUpdatingLocation()
        if let location = manager.location?.coordinate {
            completion?(
                .available(
                    .init(
                        latitude: location.latitude,
                        longitude: location.longitude
                    )
                )
            )
            completion = nil
        }
    }
}
