//
//  SearchListViewModel.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation
import RxCocoa
import RxSwift

class SearchListViewModel: ViewModelType {

    let disposeBag = DisposeBag()
    var searchList: Driver<[Item]>
    var maxIndex = 10
    let countOnce = 10 // 한번에 가져올 수 있는 갯수
    let word = "aa"
    var isFetching = false

    private let useCase: SearchUseCase

    init(searchList: Driver<[Item]>, useCase: SearchUseCase) {
        self.searchList = searchList
        self.useCase = useCase
    }

    func downloadImage(at index: Int) {
        searchList.asObservable().subscribe(onNext: { list in
            if let artworkUrl = list[index].artworkUrl60 {
                ImageLoader.loadImage(url: artworkUrl, completed: nil)
            }
        }).disposed(by: disposeBag)
    }

    func checkNeedsDownload(at index: Int) -> Bool {
        if index >= maxIndex - 3 && !isFetching {
            return true
        } else {
            return false
        }
    }

    func transform(input: Input) -> Output {
        let scrollResult = input.scrollDown.flatMapLatest { index -> Driver<[Item]> in
            if index < self.maxIndex - 3 {
                return self.searchList
            }

            let q = index / self.countOnce // 몫

            self.isFetching = true
            return self.useCase.search(search: Search(term: self.word, country: "KR", media: "software", entity: "software", limit: String((q+2) * self.countOnce)))
                .asDriver(onErrorDriveWith: Driver<SearchResult>.empty())
                .map {
                    self.maxIndex = (q+2) * self.countOnce
                    self.isFetching = false
                    return $0.results! // 새로운 result
                }
        }.asDriver(onErrorDriveWith: Driver<[Item]>.empty())

        return Output(scrollResult: scrollResult)
    }
}

extension SearchListViewModel {

    /// 인풋: 아래로 스크롤(prefetch index)
    struct Input {
        let scrollDown: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
    }

    /// 아웃풋: 서치 결과 표시
    struct Output {
        let scrollResult: Driver<[Item]>
    }
}
