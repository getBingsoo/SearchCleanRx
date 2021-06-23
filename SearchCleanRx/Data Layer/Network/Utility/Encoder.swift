//
//  Encoder.swift
//  MyAppStore
//
//  Created by 60067667 on 2021/06/10.
//

import Foundation

struct URLQueryItemEncoder {

    func encode<T>(_ value: T) -> [URLQueryItem] {
        var result: [URLQueryItem] = []
        let mirror = Mirror(reflecting: value.self)

        var resultDic: [String: String] = [:]
        mirror.children.forEach { (child) in
            guard let label = child.label else { return }
            resultDic[label] = child.value as? String
        }

        resultDic.forEach { (key, value) in
            let item = URLQueryItem(name: key, value: value)
            result.append(item)
        }

        return result
    }
}
