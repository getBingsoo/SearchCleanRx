//
//  SearchNetwork.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation
import RxSwift

class SearchNetwork {

    let network: Network<SearchResult>

    init(network: Network<SearchResult>) {
        self.network = network
    }

    func fetchItems(search: Search) -> Observable<SearchResult> {
        return Observable.create { (observer) -> Disposable in
            self.network.requestGet(param: search) { (result: Result<SearchResult, NetworkError>) in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let results):
                        observer.onNext(results)
                        observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
