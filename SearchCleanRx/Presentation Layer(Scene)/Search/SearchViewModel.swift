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

    let disposeBag = DisposeBag()
    private let useCase: SearchUseCase

    var defautlResult: Driver<[Item]> = Driver.empty()

    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }

    func transform(input: Input) -> Output {
        let moveList = input.searchClick.asDriver(onErrorJustReturn: "")
        return Output(moveList: moveList)
    }
}

extension SearchViewModel {

    /// 인풋: 서치버튼 누르기 (단어 전달)
    struct Input {
        let searchClick: PublishRelay<String> = PublishRelay<String>()
    }

    /// 아웃풋: 리스트화면으로 이동
    struct Output {
        let moveList: Driver<String>
    }
}
