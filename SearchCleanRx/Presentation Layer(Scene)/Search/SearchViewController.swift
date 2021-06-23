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

    func bindViewModel() {
        // input
        input = SearchViewModel.Input()

        // output
        guard let output = viewModel?.transform(input: input!) else { return }

        output.result
            .map { $0.results![0] }
            .emit(onNext: { result in
                // 같은 화면에 뿌릴 경우 여기에 코드 세팅
                self.coordinator?.moveSearchDetail(detail: Driver.just(result))
            }).disposed(by: disposeBag)
//
//        output.result
//            .map { $0.results! }
//            .emit(onNext: { result in
//                // todo: move coordinator
//                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//                let vc = storyboard.instantiateViewController(withIdentifier: "SearchListViewController") as! SearchListViewController
//                vc.viewModel = SearchListViewModel(searchList: Driver.just(result))
//                self.resultVC.display(vc)
//            }).disposed(by: disposeBag)

    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input?.searchClick.accept(searchBar.text ?? "") // next
    }
}
