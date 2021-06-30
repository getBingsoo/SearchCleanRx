//
//  ResultTopCell.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit

class ResultTopCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var logoImage: CustomImageView! {
        didSet {
            logoImage.layer.cornerRadius = 15
            logoImage.layer.masksToBounds = true
        }
    }

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!

    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    func configOutput(data: Item) {
        logoImage.loadImage(from: data.artworkUrl60 ?? "")
        title.text = data.trackName
        subTitle.text = data.sellerName
    }
}
