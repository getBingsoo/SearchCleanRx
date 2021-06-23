//
//  Encodable.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

// MARK: - Get
protocol URLQueryEncodable {
    func encode() -> [URLQueryItem]
}

extension URLQueryEncodable {
    func encode() -> [URLQueryItem] {
        let encoder = URLQueryItemEncoder()
        let encodedData = encoder.encode(self)

        return encodedData
    }
}

// MARK: - Post
extension Encodable {
    func encode() -> Data? {
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(self)
        return encodedData
    }
}
