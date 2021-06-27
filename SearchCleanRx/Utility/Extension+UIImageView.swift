//
//  Extension+ImageView.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit

class CustomImageView: UIImageView {

    var imageUrl: String?

    func loadImage(from url: String) {
        self.image = nil
        self.imageUrl = url

        ImageLoader.loadImage(url: url) { image in
            DispatchQueue.main.async {
                if self.imageUrl == url {
                    self.image = image
                }
            }
        }
    }
}
