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

    var searchWord = ""
    var result: Observable<SearchResult>?

    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {

        input.searchWord.drive(onNext: { word in
            self.searchWord = word
        }).disposed(by: disposeBag)

        input.searchClick.subscribe(onNext: {
            // todo search
            self.useCase.search().subscribe(onNext: { result in
                print(result)
            }).disposed(by: self.disposeBag)
            // coordinator or navigator.move
        })
        .disposed(by: disposeBag)

        return Output()
    }
}

extension SearchViewModel {

    struct Input {
        let searchWord: Driver<String>
        let searchClick: PublishRelay<Void> = PublishRelay<Void>()
    }

    struct Output {

    }
}
