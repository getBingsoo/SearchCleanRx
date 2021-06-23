//
//  UseCaseProviderNetwork.swift
//  SearchCleanRx
//
//  Created by 60067667 on 2021/06/23.
//

import Foundation

class UseCaseProviderNetwork: UseCaseProvider {

    private let networkProvider: NetworkProvider

    init() {
        self.networkProvider = NetworkProvider()
    }

    func makeSearchUseCase() -> SearchUseCase {
        let network = networkProvider.makeSearchNetwork()
        let usecase = SearchUseCaseNetwork(network: network)
        return usecase
    }
}
