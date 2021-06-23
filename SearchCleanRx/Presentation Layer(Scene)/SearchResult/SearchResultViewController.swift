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
        detailTableView.register(ResultDetailCell.self, forCellReuseIdentifier: "ResultDetailCell")
    }

    private func bindViewModel() {
        guard let viewModel = viewModel else { return }

        // cell 할당하는 방법2 - 다양한 셀 사용
        viewModel.searchDetail.map { item -> [Item] in
            var items: [Item] = []
            for _ in 0...1 {
                items.append(item)
            }
            return items
        }.drive(self.detailTableView.rx.items) { tableView, row, element in
            let indexPath = IndexPath(row: row, section: 0)
            switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTopCell", for: indexPath) as! ResultTopCell
                    cell.configOutput(data: element)
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ResultDetailCell", for: indexPath) as! ResultDetailCell
                    cell.configOutput(data: element)
                    return cell
                default:
                    return UITableViewCell()
            }
        }.disposed(by: disposeBag)

    }
}
