//
//  SearchRepositoryTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

final class MockSearchRemoteDataSource: SearchRemoteDataSourceProtocol {
    var lastQuery: String?
    var result: SearchResponseDTO!

    func search(query: String) async throws -> SearchResponseDTO {
        lastQuery = query
        return result
    }
}

final class SearchRepositoryTests: XCTestCase {
    func test_search_callsRemote_andMaps() async throws {
        let dto = SearchResponseDTO(sections: [])
        let remote = MockSearchRemoteDataSource()
        remote.result = dto

        let sut = SearchRepository(remote: remote)
        let response = try await sut.search(query: "swift")

        XCTAssertEqual(remote.lastQuery, "swift")
        XCTAssertEqual(response.sections.count, 0)
    }
}
