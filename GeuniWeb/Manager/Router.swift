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
}
