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
    var maxIndex = 20
    let countOnce = 20 // 한번에 가져올 수 있는 갯수
    var isFetching = false

    var viewDidLoad: Driver<Void>?

    private let useCase: SearchUseCase
    var word: String

    init(useCase: SearchUseCase, word: String) {
        self.useCase = useCase
        self.word = word
    }
//
//    func downloadImage(at index: Int) {
//        searchList.asObservable().subscribe(onNext: { list in
//            if let artworkUrl = list[index].artworkUrl60 {
//                ImageLoader.loadImage(url: artworkUrl, completed: nil)
//            }
//        }).disposed(by: disposeBag)
//    }

    func checkNeedsDownload(at index: Int) -> Bool {
        if index >= maxIndex - 3 && !isFetching {
            return true
        } else {
            return false
        }
    }

    func transform(input: Input) -> Output {

        // 최초 search result
        let searchResult = input.viewDidLoad.flatMap {
            return self.useCase.search(
                search: Search(term: self.word, country: "KR", media: "software", entity: "software", limit: String(self.maxIndex))
            )
            .map { $0.results! }
        }

        // 스크롤 시 search result
        let scrollResult = input.scrollDown.filter { index in
            self.checkNeedsDownload(at: index)
        }.map { fetchable -> Int in
            self.isFetching = true
            return fetchable / self.countOnce // 몫
        }.flatMapLatest {
            self.useCase.search(search: Search(term: self.word, country: "KR", media: "software", entity: "software", limit: String(($0+2) * self.countOnce)))
        }.map { result -> [Item] in
            self.maxIndex = result.resultCount!
            self.isFetching = false
            return result.results!
        }

        let result = Observable.merge(searchResult, scrollResult).asDriver(onErrorJustReturn: [])

        return Output(searchResult: result)
    }
}

extension SearchListViewModel {

    /// 인풋: 아래로 스크롤(prefetch index)
    struct Input {
        let scrollDown: BehaviorRelay<Int> = BehaviorRelay<Int>(value: 0)
        let viewDidLoad: PublishRelay<Void> = PublishRelay<Void>()
    }

    /// 아웃풋: 서치 결과 표시
    struct Output {
        let searchResult: Driver<[Item]>
    }
}
