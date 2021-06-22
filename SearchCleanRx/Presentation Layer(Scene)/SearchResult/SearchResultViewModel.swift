//
//  SearchResultViewModel.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/21.
//

import Foundation
import RxCocoa

class SearchResultViewModel {

    var searchDetail: Driver<Item>

    init(searchDetail: Driver<Item>) {
        self.searchDetail = searchDetail
    }
}
