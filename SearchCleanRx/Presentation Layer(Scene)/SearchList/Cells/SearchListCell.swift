//
//  SearchListCell.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit

class SearchListCell: UITableViewCell {

    lazy var logoImage: UIImageView = {
        let iv = UIImageView()
        return iv
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()

    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("받기", for: .normal)
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {
        contentView.addSubview(logoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(downloadButton)

        logoImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            logoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            logoImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImage.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: downloadButton.rightAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            categoryLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            downloadButton.widthAnchor.constraint(equalToConstant: 100),
            downloadButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            downloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configureCell(item: Item) {
        logoImage.loadImage(from: item.artworkUrl100 ?? "")
        titleLabel.text = item.trackName
        categoryLabel.text = item.genres?[0] ?? ""
    }
}