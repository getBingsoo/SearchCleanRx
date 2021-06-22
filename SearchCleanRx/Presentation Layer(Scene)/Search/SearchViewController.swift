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
    var viewModel = SearchViewModel(useCase: SearchUseCaseNetwork())

    var input: SearchViewModel.Input?
    @IBOutlet weak var testLabel: UILabel!

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
        // input
        input = SearchViewModel.Input()

        // output
        let output = viewModel.transform(input: input!)

        output.result
            .map { $0.results![0].trackName }
            .emit(onNext: { name in
                self.testLabel.text = name
            }).disposed(by: disposeBag)

    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        input?.searchClick.accept(searchBar.text ?? "") // next
    }
}
