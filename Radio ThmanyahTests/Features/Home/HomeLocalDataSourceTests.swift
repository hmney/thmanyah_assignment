//
//  HomeLocalDataSourceImplTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//


import XCTest
@testable import Radio_Thmanyah

final class HomeLocalDataSourceImplTests: XCTestCase {
    func test_saveAndFetch_roundTrip() async throws {
        // Isolated suite so we don't pollute real defaults
        let defaults = UserDefaults(suiteName: "home-cache-\(UUID().uuidString)")!
        let local = HomeLocalDataSource(userDefaults: defaults)

        let dto: HomeSectionsResponseDTO = FixtureLoader.decode(HomeSectionsResponseDTO.self, named: "home_page_1")
        let cached = CachedData(dto: dto, timestamp: Date())

        try await local.saveFirstPage(cached)
        let fetched = try await local.fetchFirstPage()

        XCTAssertNotNil(fetched)
        XCTAssertEqual(fetched?.dto.sections.count, dto.sections.count)
    }
}
