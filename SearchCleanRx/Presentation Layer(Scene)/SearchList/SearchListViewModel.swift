//
//  SearchListViewModel.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation
import RxCocoa

class SearchListViewModel {

    var searchList: Driver<[Item]>

    init(searchList: Driver<[Item]>) {
        self.searchList = searchList
    }
}
