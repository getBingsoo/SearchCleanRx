//
//  Extension+ImageView.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit

extension UIImageView {
    func loadImage(from url: String) {
        self.image = nil
        ImageLoader.loadImage(url: url) { image in
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}