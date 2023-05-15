//
//  BaseNavigationViewController.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/04/14.
//

import UIKit

public class BaseNavigationViewController: UINavigationController {

    public var isLockSwapeGesture = false
    private var duringTransition = false
    private var disabledPopVCs = [Any]()

    public override func viewDidLoad() {
        super.viewDidLoad()

        interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        duringTransition = true
        super.pushViewController(viewController, animated: animated)
    }
}

extension BaseNavigationViewController: UINavigationControllerDelegate {
    public func navigationController(
        _ navigationController: UINavigationController,
        didShow viewController:
        UIViewController,
        animated: Bool
    ) {
        self.duringTransition = false
    }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isLockSwapeGesture {
            return false
        }

        guard gestureRecognizer == interactivePopGestureRecognizer,
              let topVC = topViewController else {
            return true // default value
        }

        return viewControllers.count > 1 && duringTransition == false && isPopGestureEnable(topVC)
    }

    private func isPopGestureEnable(_ topVC: UIViewController) -> Bool {
        for each in disabledPopVCs where String(describing: type(of: topVC)) == String(describing: each) {
            return false
        }
        return true
    }
}
