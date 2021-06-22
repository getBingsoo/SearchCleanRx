//
//  SearchResultViewController.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/21.
//

import UIKit

class SearchResultViewController: UIViewController {

    // MARK: - IBOutlet

    @IBOutlet weak var detailTableView: UITableView!

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
    }

    private func configTableView() {
        detailTableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
    }
}
