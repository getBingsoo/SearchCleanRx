//
//  SearchListCell.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit

class SearchListCell: UITableViewCell {

    lazy var logoImage: CustomImageView = {
        let iv = CustomImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 15
        iv.layer.masksToBounds = true
        return iv
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textColor = .gray
        return label
    }()

    lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.9157019106, green: 0.9157019106, blue: 0.9157019106, alpha: 1)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle("받기", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 13)
        button.layer.cornerRadius = 15
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
        self.selectionStyle = .none
        contentView.addSubview(logoImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(downloadButton)

        logoImage.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        downloadButton.translatesAutoresizingMaskIntoConstraints = false

        let imageHeightConstraint = logoImage.heightAnchor.constraint(equalToConstant: 70)
        imageHeightConstraint.priority = UILayoutPriority(rawValue: 999)

        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 70),
            imageHeightConstraint,
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            logoImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            logoImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImage.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: logoImage.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: downloadButton.leftAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            categoryLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            categoryLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])

        NSLayoutConstraint.activate([
            downloadButton.widthAnchor.constraint(equalToConstant: 70),
            downloadButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            downloadButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    func configureCell(item: Item, completion: ((UIImage?) -> ())? = nil) {
        logoImage.loadImage(from: item.artworkUrl100 ?? "") { image in
            completion?(image)
        }
        titleLabel.text = item.trackName
        categoryLabel.text = item.genres?[0] ?? ""
    }
}
