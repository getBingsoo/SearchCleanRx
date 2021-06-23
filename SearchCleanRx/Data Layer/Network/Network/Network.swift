//
//  Network.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation

class Network<T>: Networkable where T: Decodable {
    typealias Model = T

    var url: String

    init(url: String) {
        self.url = url
    }

    /// request get
    func requestGet(param: URLQueryEncodable, completion: @escaping (Result<Model, NetworkError>) -> Void) {
        let networkInfo = NetworkInfo(url: url, param: param, method: .get)
        guard let request = networkInfo.makeRequest() else { return }

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                return completion(.failure(.parsingError))
            }

            do {
                let model = try JSONDecoder().decode(Model.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(.parsingError))
            }

        }.resume()
    }
}
