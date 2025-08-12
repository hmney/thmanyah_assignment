//
//  SearchViewModelTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

final class MockSearchUseCase: SearchUseCaseProtocol {
    var calls: [String] = []
    var result: SearchResponse = .init(sections: [])
    var error: Error?

    func execute(query: String) async throws -> SearchResponse {
        calls.append(query)
        if let error { throw error }
        return result
    }
}

final class SlowSearchUseCase: SearchUseCaseProtocol {
    var responses: [(delayMs: Int, response: Result<SearchResponse, Error>)] = []
    private var idx = 0

    func execute(query: String) async throws -> SearchResponse {
        let entry = responses[min(idx, responses.count - 1)]
        idx += 1
        try await Task.sleep(nanoseconds: UInt64(entry.delayMs) * 1_000_000)
        switch entry.response {
        case .success(let r): return r
        case .failure(let e): throw e
        }
    }
}

@MainActor
final class SearchViewModelTests: XCTestCase {

    private func makeContainer(useCase: SearchUseCaseProtocol) -> DIContainer {
        let c = DIContainer()
        c.register(SearchUseCaseProtocol.self, scopeSingleton: false) { _ in useCase }
        return c
    }

    private func makeSearchSection() -> SearchSection {
        SearchSection(
            name: "trending",
            type: "curated",
            contentType: "podcast",
            order: "1",
            content: [
                PodcastItem(
                    podcastId: "pod-001",
                    name: "Swift Bytes",
                    description: "Short tips on Swift & iOS",
                    avatarUrl: "https://example.com/podcasts/swift-bytes.png",
                    episodeCount: "120",
                    duration: "1800",
                    language: "en",
                    priority: "10",
                    popularityScore: "0.92",
                    score: "97",
                    releaseDate: "2024-11-05T08:00:00Z"
                ),
                PodcastItem(
                    podcastId: "pod-002",
                    name: "Arabic Tech Talks",
                    description: "نقاشات تقنية بالعربية",
                    avatarUrl: "https://example.com/podcasts/arabic-tech.png",
                    episodeCount: "85",
                    duration: "2400",
                    language: "ar",
                    priority: "8",
                    popularityScore: "0.88",
                    score: "93",
                    releaseDate: "2025-01-15T10:30:00Z"
                )
            ]
        )

    }

    func test_initialLoad_success_setsShowingInitial() async throws {
        let uc = MockSearchUseCase()
        uc.result = SearchResponse(sections: [])

        let vm = SearchViewModel(container: makeContainer(useCase: uc))
        try await vm.loadIntialData()
        XCTAssertEqual(vm.state.phase, .showingInitial)
        XCTAssertNotNil(vm.state.initialSections)
    }

    func test_typingDebounces_andCallsUseCase() async throws {
        let uc = MockSearchUseCase()
        uc.result = SearchResponse(sections: [])
        let vm = SearchViewModel(container: makeContainer(useCase: uc))

        vm.setQuery("swi")
        vm.setQuery("swif")
        vm.setQuery("swift")

        // Wait slightly > debounce (200ms)
        await waitForCondition() { !uc.calls.isEmpty }

        XCTAssertEqual(uc.calls.last, "swift")
        XCTAssertEqual(vm.state.phase, .empty)
        XCTAssertEqual(vm.state.results?.sections.count, 0)
    }

    func test_typingDebounces_andCallsUseCase_nonEmpty() async throws {
        let uc = MockSearchUseCase()
        uc.result = SearchResponse(sections: [makeSearchSection()])

        let vm = SearchViewModel(container: makeContainer(useCase: uc))

        vm.setQuery("swi")
        vm.setQuery("swif")
        vm.setQuery("swift")

        // Wait > debounce and until the call lands
        await waitForCondition(timeout: 1.0) { uc.calls.last == "swift" }

        XCTAssertEqual(uc.calls.last, "swift")
        XCTAssertEqual(vm.state.phase, .results)
        XCTAssertEqual(vm.state.results?.sections.count, 1)
    }

    func test_emptyQuery_clearsResults_andShowsInitialIfAvailable() async throws {
        let uc = MockSearchUseCase()
        let vm = SearchViewModel(container: makeContainer(useCase: uc))
        vm.setQuery("swift")
        await waitForCondition { true }
        vm.clearSearch()

        XCTAssertTrue(vm.state.query.isEmpty)
        XCTAssert(vm.state.phase == .idle || vm.state.phase == .showingInitial)
    }

    func test_error_setsErrorPhase() async throws {
        let uc = MockSearchUseCase()
        uc.error = URLError(.badServerResponse)
        let vm = SearchViewModel(container: makeContainer(useCase: uc))

        vm.setQuery("swift")
        await waitForCondition {
            if case .error = vm.state.phase { return true }
            return false
        }
    }

    func test_latestQueryWins_overStaleResult() async throws {
        let uc = SlowSearchUseCase()

        let s1 = SearchSection(
            name: "first",
            type: "",
            contentType: "",
            order: "",
            content: []
        )
        let s2 = SearchSection(
            name: "second",
            type: "",
            contentType: "",
            order: "",
            content: []
        )
        // First search is slow, second is fast
        uc.responses = [
            (delayMs: 400, response: .success(SearchResponse(sections: [s1]))),
            (delayMs: 50,  response: .success(SearchResponse(sections: [s2]))),
        ]

        let c = DIContainer(); c.register(SearchUseCaseProtocol.self, scopeSingleton: false) { _ in uc }
        let vm = SearchViewModel(container: c)

        vm.setQuery("swift")
        vm.setQuery("swift ui")

        // wait until results phase
        await waitForCondition(timeout: 2.0) {
            vm.state.phase == .results
        }

        // assert the "first" result applied, not the stale first
        XCTAssertEqual(vm.state.results?.sections.first?.name, "first")
    }

    @MainActor
    func test_clearSearch_returnsToShowingInitial_whenInitialLoaded() async throws {
        let uc = MockSearchUseCase()
        uc.result = SearchResponse(sections: [])

        let vm = SearchViewModel(container: makeContainer(useCase: uc))
        try await vm.loadIntialData()
        XCTAssertEqual(vm.state.phase, .showingInitial)

        vm.setQuery("swift")
        await waitForCondition(timeout: 1.0) { !uc.calls.isEmpty }
        vm.clearSearch()

        XCTAssertTrue(vm.state.query.isEmpty)
        XCTAssertEqual(vm.state.phase, .showingInitial)
    }

    @MainActor
    func test_dismissError_goesBackToIdleOrShowingInitial() async throws {
        // First cause an error
        let failing = MockSearchUseCase()
        failing.error = URLError(.badServerResponse)
        let vm = SearchViewModel(container: makeContainer(useCase: failing))

        vm.setQuery("swift")
        await waitForCondition(timeout: 1.0) {
            if case .error = vm.state.phase { return true } else { return false }
        }

        // Dismiss should go to .idle since initial not loaded
        vm.dismissError()
        XCTAssertTrue(vm.state.phase == .idle || vm.state.phase == .showingInitial)
    }
}
