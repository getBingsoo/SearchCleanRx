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

    private weak var searchListVC: SearchListViewController?

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

        if let searchListVC = makeSearchResultController() {
            let searchController = UISearchController(searchResultsController: searchListVC)
            vc.navigationItem.searchController = searchController
        }

        navigationController.pushViewController(vc, animated: true)
    }

    private func makeSearchResultController() -> SearchListViewController? {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        searchListVC = storyboard.instantiateViewController(withIdentifier: "SearchListViewController") as? SearchListViewController

        if let searchListVC = searchListVC {
            let useCaseProvider = UseCaseProviderNetwork()
            searchListVC.viewModel = SearchListViewModel(useCase: useCaseProvider.makeSearchUseCase(), word: "")
            searchListVC.coordinator = self
        }

        return searchListVC
    }

    func moveSearchDetail(detail: Driver<Item>) {
        let coordinator = SearchResultCoordinator(navigationController: self.navigationController, viewModel: SearchResultViewModel(searchDetail: detail))
        coordinator.start()
    }

    func moveSearchList(word: String) {
        searchListVC?.viewModel?.word = word
        searchListVC?.viewModel?.updateStatus(isHistory: false)
    }

    func cancelSearchAndMoveMain() {
        searchListVC?.viewModel?.updateStatus(isHistory: true)
//        if let child = momVC.children.first {
//            momVC.hide(child)
//        }
    }

    func showHistory() {
        searchListVC?.viewModel?.updateStatus(isHistory: true)
    }
}
