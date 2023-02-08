//
//  SplashViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//

import UIKit

class SplashViewController: UIViewController {

    let timeManger = TimerManager(timeInterval: 0.05, finishTime: 0.1)
    override func viewDidLoad() {
        super.viewDidLoad()
        timeManger.startTimer(tickAction: nil) {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainViewController = storyBoard.instantiateViewController(
                withIdentifier: "WebMainViewController"
            )
            let navigationController = UINavigationController(rootViewController: mainViewController)
            navigationController.modalPresentationStyle = .fullScreen
            Router.shared.navigate(fromVC: self, toVC: navigationController, animated: false)
        }
    }
}
