//
//  ViewModel.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel: ViewModelType {

    private let useCase: SearchUseCase

    let disposeBag = DisposeBag()

    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {

        let searchResult = input.searchClick.flatMapLatest { word in
            return self.useCase.search(search: Search(term: word, country: "KR", media: "software", entity: "software"))
        }.asSignal(onErrorSignalWith: Signal.empty())

        return Output(result: searchResult)
    }
}

extension SearchViewModel {

    /// 인풋: 서치버튼 누르기 (단어 전달)
    struct Input {
        let searchClick: PublishRelay<String> = PublishRelay<String>()
    }

    /// 아웃풋: 서치 결과 표시
    struct Output {
        let result: Signal<SearchResult>
    }
}
