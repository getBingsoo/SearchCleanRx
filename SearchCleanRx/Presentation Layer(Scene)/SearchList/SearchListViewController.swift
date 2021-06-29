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
        searchListTableView.register(SearchListCell.self, forCellReuseIdentifier: "SearchListCell")
        self.searchListTableView.rowHeight = UITableView.automaticDimension
        self.searchListTableView.estimatedRowHeight = 120
        bindViewModel()

    }

    private func bindViewModel() {
        let input = SearchListViewModel.Input()
        guard let output = viewModel?.transform(input: input) else { return }

        output.searchResult.drive(
            self.searchListTableView.rx.items(cellIdentifier: "SearchListCell", cellType: SearchListCell.self)) { index, element, cell in
            cell.configureCell(item: element)
        }.disposed(by: disposeBag)

        searchListTableView.rx.modelSelected(Item.self).asDriver().drive(onNext: { item in
            self.coordinator?.moveSearchDetail(detail: Driver.just(item))
        }).disposed(by: disposeBag)

        // tableView prefetch
        searchListTableView.rx.prefetchRows.asDriver()
            .drive(onNext: { indexPaths in
            if let first = indexPaths.first?.row { // 7, 8, 9
                input.scrollDown.accept(first) // next 발생
                // todo: 취소
            }
//            indexPaths.forEach { index in
//                self.viewModel?.downloadImage(at: index.row)
//            }
        }).disposed(by: disposeBag)



        // 최초 뷰 로드했을 때 list load
        input.viewDidLoad.accept(())
    }

}
