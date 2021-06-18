//
//  NetworkInfo.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

struct NetworkInfo {

    let url: String
    var param: Any
    let method: HttpMethod

    func makeRequest() -> URLRequest? {

        let method = self.method
        switch method {
            case .get:
                guard let param = self.param as? URLQueryEncodable else { return nil }
                let data = param.encode()

                var components = URLComponents(string: self.url)
                components?.queryItems = data

                var request = URLRequest(url: components!.url!)
                request.httpMethod = self.method.toString()
                return request

            case .post:
                guard let param = self.param as? Encodable else { return nil }
                guard let data = param.encode() else { return nil }

                guard let url = URL(string: self.url) else { return nil }
                var request = URLRequest(url: url)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = self.method.toString()
                request.httpBody = data

                return request
        }
    }
}
