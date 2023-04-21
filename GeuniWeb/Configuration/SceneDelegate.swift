//
//  SceneDelegate.swift
//  GeuniWeb
//
//  Created by 60157085 on 2023/02/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions:
        UIScene.ConnectionOptions
    ) {
        if (scene as? UIWindowScene) == nil {
            return
        }

        let buttonDiameter: CGFloat = 44.0
        let floatingButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: buttonDiameter, height: buttonDiameter))
        floatingButton.layer.cornerRadius = buttonDiameter / 2.0
        floatingButton.backgroundColor = .red
        window?.addSubview(floatingButton)
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }

        SNSLoginManager.shared.loginWithOpenUrl(url: url)
    }
}
