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
        bindViewModel()
    }

    private func bindViewModel() {

        let input = SearchListViewModel.Input()
        let output = viewModel?.transform(input: input)
        output?.scrollResult.drive(
            self.searchListTableView.rx.items(cellIdentifier: "SearchListCell", cellType: SearchListCell.self)) { index, element, cell in
            cell.configureCell(item: element)
            self.searchListTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .none)
        }.disposed(by: disposeBag)

        searchListTableView.rx.modelSelected(Item.self).asDriver().drive(onNext: { item in
            self.coordinator?.moveSearchDetail(detail: Driver.just(item))
        }).disposed(by: disposeBag)

        // tableView prefetch
        searchListTableView.rx.prefetchRows.asDriver()
            .drive(onNext: { indexPaths in
            if let first = indexPaths.first?.row { // 7, 8, 9
                // 다운로드가 필요한지 체크
                if self.viewModel?.checkNeedsDownload(at: first) ?? false {
                    input.scrollDown.accept(first) // next 발생
                }
                // todo: 취소
            }
//            indexPaths.forEach { index in
//                self.viewModel?.downloadImage(at: index.row)
//            }
        }).disposed(by: disposeBag)
    }

}
