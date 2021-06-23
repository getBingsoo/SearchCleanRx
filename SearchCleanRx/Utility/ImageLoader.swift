//
//  ImageLoader.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import UIKit

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
