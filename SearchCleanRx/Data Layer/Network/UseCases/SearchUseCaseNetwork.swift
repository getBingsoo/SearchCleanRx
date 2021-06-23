//
//  SearchUseCase.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation
import RxSwift

class SearchUseCaseNetwork: SearchUseCase {

    var network: SearchNetwork

    init(network: SearchNetwork) {
        self.network = network
    }

    func search(search: Search) -> Observable<SearchResult> {
        return network.fetchItems(search: search)
    }
}
