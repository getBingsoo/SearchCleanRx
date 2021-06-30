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

    /// 한번에 가져올 수 있는 갯수
    let countPerPage = 20

    /// load more 기준 (n개 앞일 때 load)
    let prefetchDistance = 4

    /// 현재 최대 인덱스
    lazy var maxIndex = countPerPage

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
        let searchResult = input.viewDidLoad.flatMap { [weak self] viewDidLoad -> Observable<SearchResult> in
            guard let self = self else { return Observable.empty() }
            self.isFetching = true
            return self.useCase.search(
                search: Search(term: self.word, country: "KR", media: "software", entity: "software", limit: String(self.maxIndex))
            )
        }.map { [weak self] searchResult -> [Item] in
            guard let self = self else { return [] }
            self.isFetching = false
            return searchResult.results ?? []
        }

        // 스크롤 시 search result
        let prefetchResult = input.prefetchCells.filter { [weak self] indexPaths -> Bool in
            // prefetch index 포함 여부
            guard let self = self else { return false }
            return indexPaths.contains(IndexPath(item: self.maxIndex - self.prefetchDistance, section: 0))
        }.filter { [weak self] _ in
            self?.isFetching == false
        }.map { [weak self] indexPaths -> Int in
            guard let self = self else { return -1 }
            if let indexPath = indexPaths.first {
                return indexPath.item / self.countPerPage // 몫
            } else {
                return -1
            }
        }.filter { quotient in
            quotient != -1 // && quotient > self.maxIndex / self.countPerPage - 2 // 이미 fetch한 경우 (스크롤 올림)
        }.flatMapLatest { [weak self] index -> Observable<SearchResult> in
            guard let self = self else { return Observable.empty() }
            self.isFetching = true
            return self.useCase.search(search: Search(term: self.word, country: "KR", media: "software", entity: "software", limit: String((index+2) * self.countPerPage)))
        }.map { [weak self] result -> [Item] in
            guard let self = self else { return [] }
            self.maxIndex = result.resultCount ?? 0
            self.isFetching = false

            return result.results ?? []
        }

        let result = Observable.merge(searchResult, prefetchResult).asDriver(onErrorJustReturn: [])

        // 이미지 prefetch할 때 미리 load하여 cache에 저장
        result.asObservable().subscribe(onNext: { [weak self] list in
            guard let self = self else { return }
            let totalCount = list.count
            let startIndex = totalCount - self.countPerPage

            guard startIndex >= 0, startIndex < totalCount else { return }

            for index in (startIndex...totalCount - 1) {
                if let artworkUrl = list[index].artworkUrl60 {
                    ImageLoader.loadImage(url: artworkUrl, completed: nil)
                }
            }
        }).disposed(by: disposeBag)

        return Output(searchResult: result)
    }
}

extension SearchListViewModel {

    /// 인풋: 아래로 스크롤(prefetch index)
    struct Input {
        let prefetchCells: BehaviorRelay<[IndexPath]> = BehaviorRelay<[IndexPath]>(value: [IndexPath(item: 0, section: 0)])
        let viewDidLoad: PublishRelay<Void> = PublishRelay<Void>()
    }

    /// 아웃풋: 서치 결과 표시
    struct Output {
        let searchResult: Driver<[Item]>
    }
}
