//
//  SearchResultCoordinator.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit

class SearchResultCoordinator: Coordinator {

    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
//    var viewModel: SearchViewModel

    init(navigationController: UINavigationController, viewModel: SearchViewModel = SearchViewModel(useCase: SearchUseCaseNetwork())) {
        self.navigationController = navigationController
        self.childCoordinators = []
//        self.viewModel = viewModel
    }

    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(identifier: "SearchResultController") as! SearchViewController

//        rootViewController.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }

}
