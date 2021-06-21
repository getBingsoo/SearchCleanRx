//
//  SomeUseCase.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation
import RxSwift

protocol SearchUseCase {
    func search(search: Search) -> Observable<SearchResult>
}

