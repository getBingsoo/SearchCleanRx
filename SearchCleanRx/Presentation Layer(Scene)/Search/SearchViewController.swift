//
//  ViewController.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/17.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {

    // MARK: - Property

    // todo: move
    var viewModel = SearchViewModel(useCase: SearchUseCaseNetwork(networkInfo: NetworkInfo(url: "https://itunes.apple.com/search", param: Search(term: "", country: "KR", media: "software", entity: "software"), method: .get)))

    var input: SearchViewModel.Input?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        bindViewModel()
    }

    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.delegate = self
    }

    func bindViewModel() {
        guard let searchBar = self.navigationItem.searchController?.searchBar else { return }

        input = SearchViewModel.Input(
            searchWord: searchBar.rx.text.orEmpty.asDriver()
        )

        let output = viewModel.transform(input: input!)
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input?.searchClick.accept(()) // next
    }
}
