//
//  TestUIViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit
import CoreLocation
import AuthenticationServices

class TestUIViewController: UIViewController {
    let userDefulatUseCase = UserDefaultsUseCase()
    var currentLocation: CLLocation?
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTest1(_ sender: Any) {
        Loading.shared.show()
    }

    @IBAction func didTest2(_ sender: Any) {

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
        Router.shared.navigateWeb(fromVC: self, toVC: WebMainViewController(), delegate: self, animated: true)
    }
}
extension TestUIViewController: WebMainViewDelegate {
    func closeWebMain(sendData: Any?) {

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
