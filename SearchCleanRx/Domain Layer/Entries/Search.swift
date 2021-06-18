//
//  Search.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

struct Search: URLQueryEncodable {
    let term: String
    let country: String
    let media: String
    let entity: String
}
