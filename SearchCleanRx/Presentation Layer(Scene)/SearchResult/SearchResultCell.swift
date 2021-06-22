//
//  SearchResultCell.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit

class SearchResultCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var logoImage: UIImageView!

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!

    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!

    private func configOutput() {
        logoImage.image = UIImage()
        title.text = ""
        subTitle.text = ""
    }
}
