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

        // 버튼 누른걸 구독을 해서, 눌렀을 때 word를 통신에 보내고 통신에서 받은 observable을 driver로 바꿔서 리턴한다.
        // driver이나 relay 만들어서.. 거기에 리절트를 넣ㅎ는다.
        // https://cloudstack.ninja/earth/cannot-convert-value-of-type-sharedsequencedriversharingstrategy-data-to-expected-argument-type/
        let result = PublishRelay<SearchResult>()

        input.searchClick.subscribe(onNext: { word in
                self.useCase.search(search: Search(term: word, country: "KR", media: "software", entity: "software")).subscribe(onNext: { searchResult in
                    result.accept(searchResult)
                }).disposed(by: self.disposeBag)
            }).disposed(by: disposeBag)
//
//        let result: Driver<SearchResult> = input.searchClick.flatMapLatest { word -> Driver<SearchResult> in
//            return self.useCase.search(search: Search(term: word, country: "KR", media: "software", entity: "software"))
//                .asDriver { error in
//                    return Driver.empty()
//                }
//        }

        return Output(result: result)
    }
}

extension SearchViewModel {

    struct Input {
        let searchClick: PublishRelay<String> = PublishRelay<String>()
    }

    struct Output {
        let result: PublishRelay<SearchResult>
    }
}
