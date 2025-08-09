//
//  APIClient.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation
import Alamofire

public protocol NetworkClient {
    func requestData(_ endpoint: Endpoint) async throws -> Data
    func requestDecodable<T: Decodable>(_ endpoint: Endpoint, decoder: JSONDecoder) async throws -> T
}

public final class AlamofireNetworkClient: NetworkClient {
    private let session: Session

    public init(session: Session = .default) {
        self.session = session
    }

    public func requestData(_ endpoint: Endpoint) async throws -> Data {
        try await session.request(
            endpoint.url,
            method: endpoint.method,
            parameters: endpoint.parameters,
            encoding: endpoint.encoding,
            headers: endpoint.headers
        )
        .validate()
        .serializingData()
        .value
    }

    public func requestDecodable<T: Decodable>(_ endpoint: Endpoint, decoder: JSONDecoder) async throws -> T {
        let data = try await requestData(endpoint)
        return try decoder.decode(T.self, from: data)
    }
}
