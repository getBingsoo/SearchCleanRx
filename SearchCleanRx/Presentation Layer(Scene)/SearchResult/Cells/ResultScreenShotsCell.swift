//
//  ResultScreenShotsCell.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/07/21.
//

import UIKit

class ResultScreenShotsCell: UITableViewCell {

    let screenCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        return collectionView
    }()

    var item: Item?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(screenCollectionView)
        screenCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.screenCollectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
            , self.screenCollectionView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10)
            , self.screenCollectionView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
            , self.screenCollectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])

        screenCollectionView.register(ScreenImageCell.self, forCellWithReuseIdentifier: "ScreenImageCell")
        screenCollectionView.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(item: Item) {
        self.item = item
        self.screenCollectionView.reloadData()
    }
}

extension ResultScreenShotsCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.screenshotUrls?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenImageCell", for: indexPath) as! ScreenImageCell
        if let item = self.item {
            cell.configureCell(url: item.screenshotUrls?[indexPath.row] ?? "")
        }
        return cell
    }
}
