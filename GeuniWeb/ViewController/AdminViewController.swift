//
//  AdminViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit
import CoreLocation
import AuthenticationServices

class AdminViewController: UIViewController {
    let userDefulatUseCase = UserDefaultsUseCase()
    var currentLocation: CLLocation?

    @IBOutlet weak var baseURLTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        let savedBaseURL = userDefulatUseCase.read(
            input: .init(key: UserDefaultKey.baseUrl.rawValue)
        ).value as? String

        baseURLTextField.text = savedBaseURL

    }

    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapRestart(_ sender: Any) {
        Router.shared.restart(fromVC: self, completion: nil)
    }

    @IBAction func didTapApplyBaseURL(_ sender: Any) {
        if let baseURL = baseURLTextField.text {
            userDefulatUseCase.write(
                input: .init(key: UserDefaultKey.baseUrl.rawValue, value: baseURL)
            )
            Toast.shared.show(option: .init(backgroundView: self.view, message: "적용완료되었습니다."))
        }
    }

    @IBAction func didTapDevelop(_ sender: Any) {
        if let developURL = AppConfigure.shared.baseUrl {
            userDefulatUseCase.write(input: .init(key: UserDefaultKey.baseUrl.rawValue, value: developURL))
        }
    }

    @IBAction func didTapRelease(_ sender: Any) {

    }
}
