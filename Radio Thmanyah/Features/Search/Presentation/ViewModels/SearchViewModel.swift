//
//  SearchViewModel.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

//
//  SearchViewModel.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI
import Combine

protocol SearchViewModelProtocol: ViewModelProtocol {}

@MainActor
final class SearchViewModel: SearchViewModelProtocol {
    @Published private(set) var state = SearchViewState()

    var onNavigate: ((SearchRoute) -> Void)?

    private let searchUseCase: SearchUseCaseProtocol
    private var searchTask: Task<Void, Never>?
    private var cancellables = Set<AnyCancellable>()

    init(container: DIContainer) {
        self.searchUseCase = container.resolve(SearchUseCaseProtocol.self)
        setupSearchTextObserver()
    }

    // MARK: - Public Methods

    func loadIntialData() async throws {
        guard case .idle = state.phase else { return }
        state.phase = .loadingInitial
        do {
            let data = try await searchUseCase.execute(query: "")
            state.initialSections = data
            state.phase = .showingInitial
        } catch {
            state.phase = .error(error.localizedDescription)
        }
    }

    func setQuery(_ text: String) { state.query = text }
//    func performSearch() async {
//        await performSearch(with: searchText)
//    }

    func clearSearch() {
        searchTask?.cancel()
        state.results = nil
        state.query = ""
        state.phase = state.initialSections == nil ? .idle : .showingInitial
    }

    func dismissError() {
        if case .error = state.phase {
            state.phase = state.initialSections == nil ? .idle : .showingInitial
        }
    }

    // MARK: - Private Methods

    private func setupSearchTextObserver() {
        $state
            .map(\.query)
            .removeDuplicates()
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                Task { @MainActor in
                    await self?.handleSearchTextChange(searchText)
                }
            }
            .store(in: &cancellables)
    }

    private func handleSearchTextChange(_ searchText: String) async {
        searchTask?.cancel()

        let trimmedText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)

        if trimmedText.isEmpty {
            clearSearch()
        } else {
            await performSearch(with: trimmedText)
        }
    }

    private func performSearch(with query: String) async {
        guard !query.isEmpty else { clearSearch(); return }

        // Set state to searching
        state.phase = .searching
        let currentQuery = query
        searchTask?.cancel()

        searchTask = Task { @MainActor in
            do {
                let response = try await searchUseCase.execute(query: currentQuery)

                guard !Task.isCancelled,
                      currentQuery == state.query.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

                state.results = response
                state.phase = response.sections.isEmpty ? .empty : .results
            } catch {
                guard !Task.isCancelled,
                      currentQuery == state.query.trimmingCharacters(in: .whitespacesAndNewlines) else { return }

                state.results = nil
                state.phase = .error(error.localizedDescription)
            }
        }
    }

//    private func setLoadingState(_ loading: Bool) {
//        isSearching = loading
//        if loading {
//            errorMessage = nil
//        }
//    }
//
//    private func updateSearchResults(_ response: SearchResponse) {
//        searchResults = response
//        isSearching = false
//        errorMessage = nil
//    }
//
//    private func handleSearchError(_ error: Error) {
//        isSearching = false
//        errorMessage = error.localizedDescription
//        searchResults = nil
//    }

    deinit {
        searchTask?.cancel()
        cancellables.removeAll()
    }
}

enum SearchPhase: Equatable {
    case idle
    case loadingInitial
    case showingInitial
    case searching
    case results
    case empty
    case error(String)
}

struct SearchViewState: Equatable {
    var query: String = ""
    var phase: SearchPhase = .idle
    var results: SearchResponse? = nil
    var initialSections: SearchResponse? = nil

    // If you still want boolean flags in views:
    var isSearching: Bool { phase == .searching }
    var isLoadingInitial: Bool { phase == .loadingInitial }
}
