//
//  Coordinator.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
