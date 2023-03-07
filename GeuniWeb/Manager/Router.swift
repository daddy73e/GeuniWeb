//
//  Router.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//
import UIKit

public class Router {

    public static let shared = Router()

    public func restart(fromVC: UIViewController) {
        Task { @MainActor in
            fromVC.view.window!.rootViewController?.dismiss(
                animated: false,
                completion: {
                    Task { @MainActor in
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        if let splashViewController = storyBoard.instantiateViewController(
                            withIdentifier: "SplashViewController"
                        ) as? PopupViewController {
                            splashViewController.modalPresentationStyle = .overFullScreen
                            fromVC.present(splashViewController, animated: false)
                        }
                    }
                })
        }
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
}
