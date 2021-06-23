//
//  AppCoordinator.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit

class AppCoordinator: Coordinator {

    let window: UIWindow
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        self.childCoordinators = []
    }

    func start() {
        window.rootViewController = navigationController

        let coordinator = SearchViewCoordinator(navigationController: navigationController)
        childCoordinators.append(coordinator)
        coordinator.start()

        window.makeKeyAndVisible()
    }
}
