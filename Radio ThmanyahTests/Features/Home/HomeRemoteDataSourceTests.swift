//
//  HomeRemoteDataSourceTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//


import XCTest
@testable import Radio_Thmanyah

final class HomeRemoteDataSourceTests: XCTestCase {
    func test_fetchFirstPage_decodesFixture() async throws {
        let data = FixtureLoader.data(named: "home_page_1")
        let client = FakeNetworkClient(data: data) // from earlier integration test
        let decoder = TestDecoder.make()

        let ds = HomeRemoteDataSource(client: client, decoder: decoder)
        let dto = try await ds.fetchFirstPage()

        XCTAssertFalse(dto.sections.isEmpty)
    }

    func test_fetchFirstPage_propagatesDecodeError() async throws {
        // Malformed JSON should throw
        let bad = FixtureLoader.data(named: "home_page_malformed")
        let client = FakeNetworkClient(data: bad)
        let decoder = TestDecoder.make()

        let ds = HomeRemoteDataSource(client: client, decoder: decoder)
        await XCTAssertThrowsErrorAsync {
            _ = try await ds.fetchFirstPage()
        }
    }
}

// Async throw helper
func XCTAssertThrowsErrorAsync(
    _ block: @escaping () async throws -> Void,
    file: StaticString = #filePath,
    line: UInt = #line
) async {
    do { try await block(); XCTFail("Expected throw", file: file, line: line) }
    catch { /* ok */ }
}
