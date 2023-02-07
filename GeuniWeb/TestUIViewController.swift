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
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestUIViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else {
            return
        }
        
        currentLocation = location
        print("위도 : ",currentLocation?.coordinate.latitude," 경도 : ",currentLocation?.coordinate.longitude)
    }
}
