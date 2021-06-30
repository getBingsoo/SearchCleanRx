//
//  ResultDetailCell.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit

class ResultDetailCell: UITableViewCell {

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
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
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10).isActive = true
    }

    func configOutput(data: Item) {
        descriptionLabel.text = data.description
    }
}
