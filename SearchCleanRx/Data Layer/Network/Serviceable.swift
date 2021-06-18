//
//  Serviceable.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

protocol Serviceable {
    var networkInfo: NetworkInfo { get set }
    func request<T: Decodable>(completion: @escaping (Result<T, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case parsingError
}
