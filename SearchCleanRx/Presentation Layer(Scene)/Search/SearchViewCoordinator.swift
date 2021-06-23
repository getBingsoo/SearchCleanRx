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

        // CleanArchitectureRx에서는 Application(Singleton)이 AppDelegate의 didFinishLaunchingWithOptions에서 이부분을 주입한다.
        let useCaseProvider = UseCaseProviderNetwork()
        vc.viewModel = SearchViewModel(useCase: useCaseProvider.makeSearchUseCase())

        navigationController.pushViewController(vc, animated: true)
    }

    func moveSearchDetail(detail: Driver<Item>) {
        let coordinator = SearchResultCoordinator(navigationController: self.navigationController, viewModel: SearchResultViewModel(searchDetail: detail))
        coordinator.start()
    }

    func moveSearchList(list: Driver<[Item]>) {
        // todo: move
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchListViewController") as! SearchListViewController
        vc.viewModel = SearchListViewModel(searchList: list)

        navigationController.pushViewController(vc, animated: true)
    }
}
