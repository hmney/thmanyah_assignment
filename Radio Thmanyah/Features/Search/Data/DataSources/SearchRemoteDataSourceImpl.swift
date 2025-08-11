//
//  SearchRemoteDataSourceImpl.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation


final class SearchRemoteDataSourceImpl: SearchRemoteDataSource {
    private let client: NetworkClient
    private let decoder: JSONDecoder

    init(
        client: NetworkClient,
        decoder: JSONDecoder
    ) {
        self.client = client
        self.decoder = decoder
    }

    func search(query: String) async throws -> SearchResponseDTO {
        let endpoint = SearchEndpoint.search(query: query)
        return try await client.requestDecodable(endpoint, decoder: decoder)
    }

}
