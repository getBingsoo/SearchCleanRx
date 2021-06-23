//
//  UseCaseProvider.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation

protocol UseCaseProvider {
    func makeSearchUseCase() -> SearchUseCase
}
