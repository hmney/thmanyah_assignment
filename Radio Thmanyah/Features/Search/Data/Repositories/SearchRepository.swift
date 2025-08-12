//
//  SearchRepository.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


class SearchRepository: SearchRepositoryProtocol {
    private let remote: SearchRemoteDataSourceProtocol

    init(remote: SearchRemoteDataSourceProtocol) {
        self.remote = remote
    }
    
    func search(query: String) async throws -> SearchResponse {
        let endpoint = SearchEndpoint.search(query: query)
        let dto = try await remote.search(query: query)
        return SearchMapper.mapSearchResponse(dto)
    }
}
