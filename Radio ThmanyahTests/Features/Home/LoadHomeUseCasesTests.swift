//
//  LoadHomeUseCasesTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

final class MockHomeRepository: HomeRepositoryProtocol {
    var firstPage: (sections: [HomeSection], pagination: Pagination)!
    var nextPage: (sections: [HomeSection], pagination: Pagination)!

    func loadFirstPage() async throws -> (sections: [HomeSection], pagination: Pagination) { firstPage }
    func loadNextPage(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) { nextPage }
}

final class LoadHomeUseCasesTests: XCTestCase {
    func test_LoadHomeFirstPageUseCase_delegatesToRepo() async throws {
        let repo = MockHomeRepository()
        repo.firstPage = ([], Pagination(nextPage: nil, totalPages: 1))

        let sut = LoadHomeFirstPageUseCase(repository: repo)
        let result = try await sut.execute()

        XCTAssertEqual(result.pagination.totalPages, 1)
    }

    func test_LoadHomeNextPageUseCase_delegatesToRepo() async throws {
        let repo = MockHomeRepository()
        repo.nextPage = ([], Pagination(nextPage: nil, totalPages: 3))

        let sut = LoadHomeNextPageUseCase(repository: repo)
        let result = try await sut.execute(path: "next")

        XCTAssertEqual(result.pagination.totalPages, 3)
    }
}
