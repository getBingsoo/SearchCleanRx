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
        bindUI()
        bindViewModel()
    }

    private func configureSearchController() {
        self.navigationItem.searchController?.searchBar.delegate = self
    }

    func bindUI() {
        let cancelClicked = navigationItem.searchController?.searchBar.rx.cancelButtonClicked.asDriver() ?? Driver.empty()
        cancelClicked.drive(onNext: {
            self.coordinator?.cancelSearchAndMoveMain()
            // todo: listViewModel 검색 결과 데이터 초기화, 또는 로딩 보여주기
        }).disposed(by: disposeBag)
//
//        let searchText = navigationItem.searchController?.searchBar.rx.text.orEmpty.asDriver() ?? Driver.empty()
//        searchText.drive(onNext: { _ in
//            self.coordinator?.showHistory()
//        }).disposed(by: disposeBag)
    }

    func bindViewModel() {
        // input
        input = SearchViewModel.Input()

        // output
        guard let output = viewModel?.transform(input: input!) else { return }

        output.moveList.drive(onNext: { word in
            self.coordinator?.moveSearchList(word: word)
        }).disposed(by: disposeBag)
    }
}

extension SearchViewController: UISearchBarDelegate {
    // navigationItem.searchController?.searchBar.rx.searchButtonClicked.asDriver() 도 되는듯
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input?.searchClick.accept(searchBar.text ?? "") // next
    }
}
