//
//  HttpMethod.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

enum HttpMethod {
    case get
    case post

    func toString() -> String {
        return String(describing: self).uppercased()
    }
}
