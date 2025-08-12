//
//  HomeRepositoryTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

// MARK: - Test Doubles
final class MockHomeRemoteDataSource: HomeRemoteDataSourceProtocol {
    var fetchFirstPageCalled = false
    var fetchNextPageCalled = false
    var firstPageResult: HomeSectionsResponseDTO!
    var nextPageResult: HomeSectionsResponseDTO!

    func fetchFirstPage() async throws -> HomeSectionsResponseDTO {
        fetchFirstPageCalled = true
        return firstPageResult
    }

    func fetchNextPage(pathOrURL: String) async throws -> HomeSectionsResponseDTO {
        fetchNextPageCalled = true
        return nextPageResult
    }
}

final class MockHomeLocalDataSource: HomeLocalDataSourceProtocol {
    var stored: CachedData?
    func saveFirstPage(_ data: CachedData) async throws { stored = data }
    func fetchFirstPage() async throws -> CachedData? { stored }
    init(firstPage: CachedData? = nil) { self.stored = firstPage }
}

// MARK: - Tests
final class HomeRepositoryTests: XCTestCase {

    private func loadDTO(_ name: String) throws -> HomeSectionsResponseDTO {
        let data = FixtureLoader.data(named: name)
        return try TestDecoder.make().decode(HomeSectionsResponseDTO.self, from: data)
    }

    func test_returnsCachedData_whenNotExpired() async throws {
        let dto = try loadDTO("home_page_1")
        let cached = CachedData(dto: dto, timestamp: Date())

        let remote = MockHomeRemoteDataSource()
        let local = MockHomeLocalDataSource(firstPage: cached)
        let sut = HomeRepository(remote: remote, local: local)

        let result = try await sut.loadFirstPage()

        XCTAssertEqual(result.sections.count, dto.sections.count)
        XCTAssertFalse(remote.fetchFirstPageCalled, "Should not call remote when cache is valid")
    }

    func test_callsRemoteAndSavesCache_whenCacheMissing() async throws {
        let dto = try loadDTO("home_page_1")
        let remote = MockHomeRemoteDataSource()
        remote.firstPageResult = dto
        let local = MockHomeLocalDataSource()

        let sut = HomeRepository(remote: remote, local: local)
        let result = try await sut.loadFirstPage()

        XCTAssertTrue(remote.fetchFirstPageCalled)
        XCTAssertEqual(local.stored?.dto.pagination.nextPage, dto.pagination.nextPage)
        XCTAssertEqual(result.sections.count, dto.sections.count)
    }

    func test_loadNextPage_callsRemoteAndMaps() async throws {
        let nextDTO = try loadDTO("home_page_1")
        let remote = MockHomeRemoteDataSource()
        remote.nextPageResult = nextDTO
        let local = MockHomeLocalDataSource()

        let sut = HomeRepository(remote: remote, local: local)
        let result = try await sut.loadNextPage(path: "next-url-or-path")

        XCTAssertTrue(remote.fetchNextPageCalled)
        XCTAssertEqual(result.sections.count, nextDTO.sections.count)
    }

    func test_usesRemote_whenCacheExpired() async throws {
        let dto = try loadDTO("home_page_1")

        // Expired cache (older than 5 minutes)
        let expired = CachedData(dto: dto, timestamp: Date().addingTimeInterval(-6 * 60))

        let remote = MockHomeRemoteDataSource()
        remote.firstPageResult = dto

        let local = MockHomeLocalDataSource(firstPage: expired)

        let sut = HomeRepository(remote: remote, local: local)
        let result = try await sut.loadFirstPage()

        XCTAssertTrue(remote.fetchFirstPageCalled, "Should hit remote when cache is expired")
        XCTAssertEqual(result.sections.count, dto.sections.count)
        // Ensures new cache saved
        XCTAssertNotNil(local.stored)
        XCTAssertGreaterThan(local.stored!.timestamp, expired.timestamp)
    }
}
