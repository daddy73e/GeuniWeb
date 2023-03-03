//
//  Router.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/08.
//
import UIKit

public class Router {

    public static let shared = Router()

    public func navigate(
        fromVC: UIViewController,
        toVC: UIViewController,
        animated: Bool
    ) {
        if let navigationController = fromVC.navigationController {
            navigationController.pushViewController(toVC, animated: animated)
        } else {
            fromVC.present(toVC, animated: animated)
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
        DispatchQueue.main.async {
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
