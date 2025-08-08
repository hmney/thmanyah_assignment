//
//  HomePhase.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var state = HomeViewState()

    private let loadHomeFirstPage: LoadHomeFirstPage
    private let loadHomeNextPage: LoadHomeNextPage

    private var isLoadingFirst = false
    private var isLoadingNext = false

    init(loadHomeFirstPage: LoadHomeFirstPage, loadHomeNextPage: LoadHomeNextPage) {
        self.loadHomeFirstPage = loadHomeFirstPage
        self.loadHomeNextPage = loadHomeNextPage
    }

    func onAppear() {
        guard case .idle = state.phase else { return }
        Task { await load() }
    }

    func refresh() {
        Task { await load() }
    }

    private func load() async {
        guard !isLoadingFirst else { return }
        isLoadingFirst = true
        state.phase = .loading
        do {
            let result = try await loadHomeFirstPage.execute()
            if result.sections.isEmpty {
                state = .init(phase: .empty, sections: [], nextPage: result.pagination.nextPage)
            } else {
                state = .init(phase: .content, sections: result.sections, nextPage: result.pagination.nextPage)
            }
        } catch {
            state.phase = .error("حدث خطأ. حاول مرة أخرى.")
        }
        isLoadingFirst = false
    }

    func loadNextPageIfNeeded() {
        guard case .content = state.phase else { return }
        guard !isLoadingNext else { return }
        guard let next = state.nextPage else { return }
//        guard let lastID = state.sections.last?.id, lastID == currentSectionID else { return }

        isLoadingNext = true
        Task {
            defer { isLoadingNext = false }
            do {
                let result = try await loadHomeNextPage.execute(path: next)

                // Deduplicate by id, then keep order by existing + new
                let existingIDs = Set(state.sections.map { $0.id })
                let newUnique = result.sections.filter { !existingIDs.contains($0.id) }
                var merged = state.sections + newUnique
                // Sort by "order" if present; otherwise keep as appended
                merged.sort { ($0.order) < ($1.order) }

                state.sections = merged
                state.nextPage = result.pagination.nextPage
            } catch {
                // Keep content, optionally surface a toast/flag
            }
        }
    }
}

enum HomePhase: Equatable {
    case idle, loading, content, empty, error(String)
}

struct HomeViewState: Equatable {
    var phase: HomePhase = .idle
    var sections: [HomeSection] = []
    var nextPage: String? = nil
}
