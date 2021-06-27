//
//  SearchListViewModel.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation
import RxCocoa
import RxSwift

class SearchListViewModel {

    var searchList: Driver<[Item]>
    let disposeBag = DisposeBag()

    init(searchList: Driver<[Item]>) {
        self.searchList = searchList
    }

    func downloadImage(at index: Int) {
        searchList.asObservable().subscribe(onNext: { list in
            ImageLoader.loadImage(url: list[index].artworkUrl60 ?? "", completed: nil)
        }).disposed(by: disposeBag)
    }
}
