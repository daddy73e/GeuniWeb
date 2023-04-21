//
//  Router.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//
import UIKit

public class Router {

    public static let shared = Router()

    public func restart(
        fromVC: UIViewController,
        completion: (() -> Void)?
    ) {
        Toast.shared.hide(animate: true, completion: {
            Task { @MainActor in
                fromVC.view.window!.rootViewController?.dismiss(
                    animated: false,
                    completion: completion
                )
            }
        })
    }

    public func navigate(
        fromVC: UIViewController,
        toVC: UIViewController,
        animated: Bool
    ) {
        Task { @MainActor in
            if let navigationController = fromVC.navigationController {
                navigationController.pushViewController(toVC, animated: animated)
            } else {
                fromVC.present(toVC, animated: animated)
            }
        }
    }

    public func navigateWeb(
        fromVC: UIViewController,
        toVC: WebMainViewController,
        delegate: WebMainViewDelegate,
        animated: Bool
    ) {
        toVC.delegate = delegate
        if let navigationController = fromVC.navigationController {
            navigationController.pushViewController(toVC, animated: animated)
        } else {
            fromVC.present(toVC, animated: animated)
        }
    }

    public func showPopup(
        fromVC: UIViewController,
        popupInput: PopupInput
    ) {
        Task { @MainActor in
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let popupViewController = storyBoard.instantiateViewController(
                withIdentifier: "PopupViewController"
            ) as? PopupViewController {
                popupViewController.configure(input: popupInput)
                popupViewController.modalPresentationStyle = .overCurrentContext
                fromVC.present(popupViewController, animated: false)
            }
        }
    }

    public func openSettingPage() {
        if let bundle = Bundle.main.bundleIdentifier,
           let settings = URL(string: UIApplication.openSettingsURLString + bundle) {
            if UIApplication.shared.canOpenURL(settings) {
                UIApplication.shared.open(settings)
            }
        }
    }
}
