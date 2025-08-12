//
//  HomeViewModelTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
import SwiftUI
@testable import Radio_Thmanyah

final class MockLoadHomeFirstPageUseCase: LoadHomeFirstPageUseCase {
    private let _execute: () async throws -> (sections: [HomeSection], pagination: Pagination)
    init(_ impl: @escaping () async throws -> (sections: [HomeSection], pagination: Pagination)) {
        self._execute = impl
        super.init(repository: MockHomeRepository())
    }
    override func execute() async throws -> (sections: [HomeSection], pagination: Pagination) { try await _execute() }
}

final class MockLoadHomeNextPageUseCase: LoadHomeNextPageUseCase {
    private let _execute: (_ path: String) async throws -> (sections: [HomeSection], pagination: Pagination)
    init(_ impl: @escaping (_ path: String) async throws -> (sections: [HomeSection], pagination: Pagination)) {
        self._execute = impl
        super.init(repository: MockHomeRepository())
    }
    override func execute(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) {
        try await _execute(path)
    }
}

@MainActor
final class HomeViewModelTests: XCTestCase {
    @MainActor private func makeContainer(
        first: @escaping () async throws -> (sections: [HomeSection], pagination: Pagination),
        next: @escaping (_ path: String) async throws -> (sections: [HomeSection], pagination: Pagination)
    ) -> DIContainer {
        let c = DIContainer()
        c.register(LoadHomeFirstPageUseCaseProtocol.self, scopeSingleton: false) { _ in
            MockLoadHomeFirstPageUseCase(first)
        }
        c.register(
                LoadHomeNextPageUseCaseProtocol.self,
                scopeSingleton: false
            ) { _ in
            MockLoadHomeNextPageUseCase(next)
        }
        return c
    }

    @MainActor
    func test_onAppear_loadsContent() async throws {
        let section = HomeSection(
            title: "Title",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )

        let container = makeContainer(
            first: { ([section], Pagination(nextPage: "next", totalPages: 2)) },
            next: { _ in ([], Pagination(nextPage: nil, totalPages: 2)) }
        )

        let vm = HomeViewModel(container: container)

        // Verify initial state
        XCTAssertEqual(vm.state.phase, .idle)

        // Trigger loading
        vm.onAppear()

        // Wait for loading to complete
        await waitForCondition(timeout: 5.0) {
            vm.state.phase == .content
        }

        // Verify final state
        XCTAssertEqual(vm.state.sections, [section])
        XCTAssertEqual(vm.displayedSections, [section])
    }

    @MainActor
    func test_pagination_appendsSections() async throws {
        let firstSection = HomeSection(
            title: "First Section",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )
        let secondSection = HomeSection(
            title: "Second Section",
            displayStyle: .bigSquare,
            contentKind: .episode(""),
            order: 2,
            items: []
        )

        let container = makeContainer(
            first: { ([firstSection], Pagination(nextPage: "p2", totalPages: 2)) },
            next: { _ in ([secondSection], Pagination(nextPage: nil, totalPages: 2)) }
        )

        let vm = HomeViewModel(container: container)

        // Load first page
        vm.onAppear()
        await waitForCondition {
            vm.state.phase == .content
        }

        // Verify first page loaded
        XCTAssertEqual(vm.state.sections.count, 1)
        XCTAssertEqual(vm.state.sections.first, firstSection)

        // Load next page
        vm.loadNextPageIfNeeded()
        await waitForCondition {
            vm.state.sections.count == 2 && !vm.state.isPaginating
        }

        // Verify both sections are present
        XCTAssertEqual(vm.state.sections.count, 2)
        XCTAssertEqual(vm.state.sections.first, firstSection)
        XCTAssertEqual(vm.state.sections.last, secondSection)
    }

    @MainActor
    func test_error_setsErrorPhase() async throws {
        let container = makeContainer(
            first: { throw URLError(.badServerResponse) },
            next: { _ in ([], Pagination(nextPage: nil, totalPages: 1)) }
        )

        let vm = HomeViewModel(container: container)

        vm.onAppear()

        // Wait for error state
        await waitForCondition {
            if case .error = vm.state.phase { return true }
            return false
        }

        // Verify error state
        guard case .error(let message) = vm.state.phase else {
            XCTFail("Expected error phase")
            return
        }
        XCTAssertEqual(message, "Error, try again!")
    }

    @MainActor
    func test_refresh_reloadsContent() async throws {
        let section = HomeSection(
            title: "Title",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )

        var callCount = 0
        let container = makeContainer(
            first: {
                callCount += 1
                return ([section], Pagination(nextPage: nil, totalPages: 1))
            },
            next: { _ in ([], Pagination(nextPage: nil, totalPages: 1)) }
        )

        let vm = HomeViewModel(container: container)

        // Initial load
        vm.onAppear()
        await waitForCondition {
            vm.state.phase == .content
        }
        XCTAssertEqual(callCount, 1)

        // Refresh
        vm.refresh()
        await waitForCondition {
            callCount == 2 && vm.state.phase == .content
        }

        XCTAssertEqual(callCount, 2)
    }

    func test_canLoadMore_returnsCorrectValue() async throws {
        let section = HomeSection(
            title: "Title",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )

        let container = makeContainer(
            first: { ([section], Pagination(nextPage: "p2", totalPages: 3)) },
            next: { _ in ([section], Pagination(nextPage: "p3", totalPages: 3)) }
        )

        let vm = HomeViewModel(container: container)

        // Initially should be able to load more (assuming currentPage starts at 1, totalPages will be 3)
        vm.onAppear()
        await waitForCondition {
            vm.state.phase == .content
        }

        XCTAssertTrue(vm.canLoadMore)

        // After loading next page, should still be able to load more
        vm.loadNextPageIfNeeded()
        await waitForCondition {
            !vm.state.isPaginating
        }

        XCTAssertTrue(vm.canLoadMore)
    }

    @MainActor
    func test_displayedSections_filtersCorrectly() async throws {
        let podcastSection = HomeSection(
            title: "Podcasts",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )
        let episodeSection = HomeSection(
            title: "Episodes",
            displayStyle: .bigSquare,
            contentKind: .episode(""),
            order: 2,
            items: []
        )

        let container = makeContainer(
            first: { ([podcastSection, episodeSection], Pagination(nextPage: nil, totalPages: 1)) },
            next: { _ in ([], Pagination(nextPage: nil, totalPages: 1)) }
        )

        let vm = HomeViewModel(container: container)

        vm.onAppear()
        await waitForCondition {
            vm.state.phase == .content
        }

        // Initially should show all sections
        XCTAssertEqual(vm.displayedSections.count, 2)

        vm.selectedFilterBinding.wrappedValue = .episodes

        let filtered = vm.displayedSections
        XCTAssertEqual(filtered.count, 1)

        if case .episode = filtered.first?.contentKind {
            // OK
        } else {
            XCTFail("Expected an .episode section after filtering to .episodes")
        }
    }

    @MainActor
    final class CountingHomeRepository: HomeRepositoryProtocol {
        var firstCount = 0
        let firstResult: (sections: [HomeSection], pagination: Pagination)

        init(firstResult: (sections: [HomeSection], pagination: Pagination)) {
            self.firstResult = firstResult
        }
        func loadFirstPage() async throws -> (sections: [HomeSection], pagination: Pagination) {
            firstCount += 1
            return firstResult
        }
        func loadNextPage(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) {
            return ([], Pagination(nextPage: nil, totalPages: 1))
        }
    }

    func test_onAppear_isIdempotent() async throws {
        let section = HomeSection(
            title: "Podcasts",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )
        let repo = CountingHomeRepository(firstResult: ([section], Pagination(nextPage: nil, totalPages: 1)))

        let container = makeContainer(
            first: { try await repo.loadFirstPage() },
            next:  { path in try await repo.loadNextPage(path: path) }
        )

        let vm = HomeViewModel(container: container)

        vm.onAppear()
        vm.onAppear() // second call should be ignored due to `guard case .idle`

        // Wait until loaded
        await waitForCondition(timeout: 3) {
            vm.state.phase == .content
        }
        XCTAssertEqual(repo.firstCount, 1, "onAppear should only trigger one load")
    }

    func test_loadNextPageIfNeeded_doesNothing_whenNextPageNil() async throws {
        let section = HomeSection(
            title: "Podcasts",
            displayStyle: .bigSquare,
            contentKind: .podcast(""),
            order: 1,
            items: []
        )
        let c = makeContainer(
            first: { ([section], Pagination(nextPage: nil, totalPages: 1)) },
            next:  { _ in XCTFail("Should not call next"); return ([], Pagination(nextPage: nil, totalPages: 1)) }
        )

        let vm = HomeViewModel(container: c)
        vm.onAppear()
        await waitForCondition {
            vm.state.phase == .content
        }

        vm.loadNextPageIfNeeded()
        // Assert unchanged
        XCTAssertEqual(vm.state.sections, [section])
    }

}
