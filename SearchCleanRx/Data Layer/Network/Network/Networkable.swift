//
//  Networkable.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

protocol Networkable {
    associatedtype Model where Model: Decodable
    var url: String { get set }
    func requestGet(param: URLQueryEncodable, completion: @escaping (Result<Model, NetworkError>) -> Void)
}

enum NetworkError: Error {
    case parsingError
}

