//
//  TestUIViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit
import CoreLocation

class TestUIViewController: UIViewController {
    let userDefulatUseCase = UserDefaultUseCase()
    var currentLocation: CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTest1(_ sender: Any) {
        let locationUseCase = LocationUseCase()
        locationUseCase.request(input: .init(delegate: self))
    }

    @IBAction func didTest2(_ sender: Any) {
        let locationUseCase = LocationUseCase()
        switch locationUseCase.permissionCheck().permission {
        case .access:
            print("사용가능")
        default:
            print("세팅창으로")
        }
    }

    @IBAction func didTest3(_ sender: Any) {
        let contectsUseCase = ContactsUseCase()
        contectsUseCase.request { [weak self] output in
            if output.isPermissionAccess {
                print(output.contacts)
            } else {
                self?.routeSettingPage()
            }
        }
    }

    @IBAction func didTest4(_ sender: Any) {
        Router.shared.showPopup(
            fromVC: self,
            popupInput: .init(
                title: "TEST",
                contents: "Contents",
                delegate: self
            )
        )
    }
}

extension TestUIViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.last else {
            return
        }
        currentLocation = location
    }
}

extension TestUIViewController {
    override func becomeFirstResponder() -> Bool {
        return true
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            print("Shake Gesture Detected")
        }
    }
}

extension TestUIViewController: PopupViewDelegate {
    func responsePopupResult(output: PopupOutPut) {
        print("output = \(output)")
    }
}
