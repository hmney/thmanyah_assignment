//
//  SearchUseCaseProtocol.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


protocol SearchUseCaseProtocol {
    func execute(query: String) async throws -> SearchResponse
}

class SearchUseCase: SearchUseCaseProtocol {
    private let repository: SearchRepositoryProtocol

    init(repository: SearchRepositoryProtocol) {
        self.repository = repository
    }

    func execute(query: String) async throws -> SearchResponse {
        return try await repository.search(query: query)
    }
}
