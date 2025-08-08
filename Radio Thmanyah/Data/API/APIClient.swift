//
//  APIClient.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

protocol APIClientProtocol {
    func getRaw(_ endpoint: Endpoint) async throws -> Data
}

final class APIClient: APIClientProtocol {

    func getRaw(_ endpoint: Endpoint) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: endpoint.url)
        return data
    }
}
