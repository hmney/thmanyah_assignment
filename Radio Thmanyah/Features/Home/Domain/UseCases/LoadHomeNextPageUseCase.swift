//
//  LoadHomeNextPageUseCase.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

protocol LoadHomeNextPageUseCaseProtocol {
    func execute(path: String) async throws -> (sections: [HomeSection], pagination: Pagination)
}

class LoadHomeNextPageUseCase: LoadHomeNextPageUseCaseProtocol {
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    func execute(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) {
        return try await repository.loadNextPage(path: path)
    }
}
