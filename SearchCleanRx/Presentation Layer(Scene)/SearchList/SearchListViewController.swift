//
//  SearchListViewController.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit
import RxSwift
import RxCocoa

class SearchListViewController: UIViewController {

    // MARK: - Property

    var viewModel: SearchListViewModel?
    let disposeBag = DisposeBag()

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
        viewModel?.searchList.drive(
            self.searchListTableView.rx.items(cellIdentifier: "SearchListCell", cellType: SearchListCell.self)) { index, element, cell in
            cell.configureCell(item: element)
//            self.searchListTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
        }.disposed(by: disposeBag)
    }
}
