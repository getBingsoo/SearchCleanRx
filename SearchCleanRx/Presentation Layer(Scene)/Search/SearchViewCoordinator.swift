//
//  SearchViewCoordinator.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit
import RxCocoa

class SearchViewCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

    func moveSearchDetail(detail: Driver<Item>) {
        let coordinator = SearchResultCoordinator(navigationController: self.navigationController, viewModel: SearchResultViewModel(searchDetail: detail))
        coordinator.start()
    }
}
