//
//  ScreenImageCell.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/07/30.
//

import UIKit

class ScreenImageCell: UICollectionViewCell {

    let image: CustomImageView = {
        let iv = CustomImageView()
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)

        self.contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10)
            , image.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10)
            , image.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
            , image.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(url: String) {
        self.image.loadImage(from: url)
    }
}
