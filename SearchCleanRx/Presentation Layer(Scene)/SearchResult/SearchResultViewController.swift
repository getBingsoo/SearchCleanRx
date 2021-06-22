//
//  SearchResultViewController.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/21.
//

import UIKit
import RxCocoa
import RxSwift

class SearchResultViewController: UIViewController {

    // MARK: - Property

    var coordinator: SearchResultCoordinator?
    var viewModel: SearchResultViewModel?
    var disposeBag = DisposeBag()

    // MARK: - IBOutlet

    @IBOutlet weak var detailTableView: UITableView!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
        bindViewModel()
    }

    private func configTableView() {
        detailTableView.rowHeight = UITableView.automaticDimension
        detailTableView.estimatedRowHeight = UITableView.automaticDimension
//        detailTableView.register(UINib(nibName: "SearchResultCell", bundle: nil), forCellReuseIdentifier: "SearchResultCell")
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
//        viewModel.searchDetail.map { item -> [Item] in
//            var items: [Item] = []
//            for _ in 0...5 {
//                items.append(item)
//            }
//            return items
//        }.asObservable()
//        .bind(to: self.detailTableView.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchResultCell.self)) { index, element, cell in
//            cell.configOutput(data: element)
//            self.detailTableView.reloadData()
//        }.disposed(by: disposeBag)

        viewModel.searchDetail.map { item -> [Item] in
            var items: [Item] = []
            for _ in 0...5 {
                items.append(item)
            }
            return items
        }.drive(self.detailTableView.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchResultCell.self)) { index, element, cell in
            cell.configOutput(data: element)
        }.disposed(by: disposeBag)


//        viewModel?.searchDetail.drive(onNext: { detail in
//            self.detailTableView.rx.items(cellIdentifier: "SearchResultCell", cellType: SearchResultCell.self) {
//
//            }
//        })
    }
}
