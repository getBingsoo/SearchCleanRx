//
//  SceneDelegate.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)

        let coordinator = AppCoordinator(window: window!)
        coordinator.start()
    }

}

