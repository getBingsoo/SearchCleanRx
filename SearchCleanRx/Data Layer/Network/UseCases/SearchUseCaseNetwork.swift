//
//  SearchUseCase.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation
import RxSwift

class SearchUseCaseNetwork: SearchUseCase, Serviceable {

    var networkInfo: NetworkInfo?

    func search(search: Search) -> Observable<SearchResult> {

        networkInfo = NetworkInfo(url: "https://itunes.apple.com/search", param: search, method: .get)

        return Observable.create { (observer) -> Disposable in
            self.request { (result: Result<SearchResult, NetworkError>) in
                switch result {
                    case .failure(let error):
                        observer.onError(error)
                    case .success(let results):
                        observer.onNext(results)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }

    func request<T>(completion: @escaping (Result<T, NetworkError>) -> Void) where T : Decodable {
        guard let request = networkInfo?.makeRequest() else { return }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return completion(.failure(.parsingError))
            }

            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.parsingError))
            }

        }.resume()
    }
}
