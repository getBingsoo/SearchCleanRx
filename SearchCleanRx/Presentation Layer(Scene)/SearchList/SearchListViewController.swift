//
//  SearchListViewController.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit
import RxSwift
import RxCocoa

/// Search List VC
class SearchListViewController: UIViewController {

    // MARK: - Property

    var viewModel: SearchListViewModel?
    let disposeBag = DisposeBag()
    var coordinator: SearchViewCoordinator?

    // MARK: - IBOutlet

    @IBOutlet weak var searchListTableView: UITableView!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.largeTitleDisplayMode = .never // 상단 아래로 스크롤 안되게
        searchListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "HistoryCell")
        searchListTableView.register(SearchListCell.self, forCellReuseIdentifier: "SearchListCell")

        self.searchListTableView.rowHeight = UITableView.automaticDimension
        self.searchListTableView.estimatedRowHeight = 120
        bindViewModel()
    }

    private func bindViewModel() {
        let input = SearchListViewModel.Input()
        guard let output = viewModel?.transform(input: input) else { return }


        viewModel?.displayMode.asDriver().drive(onNext: { [weak self] isHistory in
            guard let self = self else { return }
            if isHistory {
                self.searchListTableView.delegate = nil
                self.searchListTableView.dataSource = nil
                output.searchResult.drive(
                    self.searchListTableView.rx.items(cellIdentifier: "HistoryCell", cellType: UITableViewCell.self)) { index, element, cell in

                }.disposed(by: self.disposeBag)
            } else {
                self.searchListTableView.delegate = nil
                self.searchListTableView.dataSource = nil

                output.searchResult.drive(
                    self.searchListTableView.rx.items(cellIdentifier: "SearchListCell", cellType: SearchListCell.self)) { index, element, cell in
                    cell.configureCell(item: element)
                }.disposed(by: self.disposeBag)

                // 최초 뷰 로드했을 때 list load
                input.viewDidLoad.accept(())

            }
        }).disposed(by: disposeBag)

        searchListTableView.rx.modelSelected(Item.self).asDriver().drive(onNext: { [weak self] item in
            self?.coordinator?.moveSearchDetail(detail: Driver.just(item))
        }).disposed(by: disposeBag)

        // tableView prefetch
        searchListTableView.rx.prefetchRows.asDriver()
            .drive(onNext: { indexPaths in
                input.prefetchCells.accept(indexPaths) // fetch more (pager)
            }).disposed(by: disposeBag)

    }
}

