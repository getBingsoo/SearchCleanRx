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

    let disposeBag = DisposeBag()

    // todo: move
    let resultVC = SearchResultMomController()
    var coordinator: SearchViewCoordinator?
    var viewModel: SearchViewModel?

    var input: SearchViewModel.Input?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Search"
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true

        configureSearchController()
        bindViewModel()
    }

    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: resultVC)
        self.navigationItem.searchController = searchController
        self.navigationItem.searchController?.searchBar.delegate = self
    }

    func bindUI() {
        let cancelClicked = navigationItem.searchController?.searchBar.rx.cancelButtonClicked.asDriver() ?? Driver.empty()
        cancelClicked.drive(onNext: {
            self.coordinator?.cancelSearchAndMoveMain(momVC: self.resultVC)
        }).disposed(by: disposeBag)
    }

    func bindViewModel() {
        // input
        input = SearchViewModel.Input()

        // output
        guard let output = viewModel?.transform(input: input!) else { return }

        output.result
            .map { $0.results! }
            .emit(onNext: { result in
                // todo: move coordinator
                self.coordinator?.moveSearchList(momVC: self.resultVC, list: Driver.just(result))
            }).disposed(by: disposeBag)
    }
}

extension SearchViewController: UISearchBarDelegate {
    // navigationItem.searchController?.searchBar.rx.searchButtonClicked.asDriver() 도 되는듯
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input?.searchClick.accept(searchBar.text ?? "") // next
    }
}
