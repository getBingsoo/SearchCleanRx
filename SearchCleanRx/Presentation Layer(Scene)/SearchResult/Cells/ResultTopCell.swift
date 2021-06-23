//
//  ResultTopCell.swift
//  SearchCleanRx
//
//  Created by Lina Choi on 2021/06/22.
//

import UIKit

class ResultTopCell: UITableViewCell {

    // MARK: - IBOutlet

    @IBOutlet weak var logoImage: UIImageView!

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

class ImageLoader {
    static func loadImage(url: String, completed: @escaping (UIImage?) -> Void) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { (data, resonse, error) in
                if error != nil {
                    completed(nil)
                }
                if let data = data {
                    let image = UIImage(data: data)
                    completed(image)
                } else {
                    completed(nil)
                }
            }.resume()
        } else {
            completed(nil)
        }
    }
}
