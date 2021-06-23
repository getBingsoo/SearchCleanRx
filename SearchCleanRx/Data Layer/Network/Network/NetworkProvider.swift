//
//  NetworkProvider.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation

class NetworkProvider {

    private let url = "https://itunes.apple.com/search"

    func makeSearchNetwork() -> SearchNetwork {
        return SearchNetwork(network: Network<SearchResult>(url: url))
    }
}
