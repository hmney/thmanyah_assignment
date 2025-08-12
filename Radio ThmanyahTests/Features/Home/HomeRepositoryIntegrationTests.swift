//
//  HomeRepositoryIntegrationTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

/// A tiny fake NetworkClient that returns fixture data for any endpoint.
final class FakeNetworkClient: NetworkClient {
    let data: Data
    init(data: Data) { self.data = data }
    func requestData(_ endpoint: Endpoint) async throws -> Data { data }
    func requestDecodable<T: Decodable>(_ endpoint: Endpoint, decoder: JSONDecoder) async throws -> T {
        try decoder.decode(T.self, from: data)
    }
}

final class HomeRepositoryIntegrationTests: XCTestCase {
    func test_firstPage_flowsEndToEnd_andPersistsCache() async throws {
        // Given: network returns real fixture
        let json = FixtureLoader.data(named: "home_page_1")
        let client = FakeNetworkClient(data: json)
        let decoder = TestDecoder.make()

        let remote = HomeRemoteDataSource(client: client, decoder: decoder)
        let local = HomeLocalDataSource(userDefaults: UserDefaults(suiteName: "home-cache-\(UUID().uuidString)")!)

        let sut = HomeRepository(remote: remote, local: local)

        // When: first call hits network and saves cache
        let first = try await sut.loadFirstPage()

        // Then: we get sections mapped
        XCTAssertFalse(first.sections.isEmpty)

        // And: second call should come from cache (no network observable here,
        // but data equality + non-empty cache proves persistence path)
        let cached = try await local.fetchFirstPage()
        XCTAssertNotNil(cached)
        XCTAssertEqual(cached?.dto.sections.count, first.sections.count)
    }
}
