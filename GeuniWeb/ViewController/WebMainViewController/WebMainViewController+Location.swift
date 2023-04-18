//
//  WebMainViewController+Location.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/18.
//

import Foundation
import CoreLocation

extension WebMainViewController: CLLocationManagerDelegate {
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else {
            return
        }

        print("location = \(location)")
    }
}
