//
//  ViewModelType.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/18.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    func transform(input: Input) -> Output
}
