//
//  HomeRemoteDataSource.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import Foundation
import Alamofire

final class HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
    private let client: NetworkClient
    private let decoder: JSONDecoder

    init(
        client: NetworkClient,
        decoder: JSONDecoder
    ) {
        self.client = client
        self.decoder = decoder
    }

    func fetchFirstPage() async throws -> HomeSectionsResponseDTO {
        let endpoint = HomeEndpoint.firstPage
        return try await client.requestDecodable(endpoint, decoder: decoder)
    }

    func fetchNextPage(pathOrURL: String) async throws -> HomeSectionsResponseDTO {
        let endpoint = HomeEndpoint.nextPage(path: pathOrURL)
        return try await client.requestDecodable(endpoint, decoder: decoder)
    }
}
