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
    @Published private(set) var isPaginating = false

    var canLoadMore: Bool {
        currentPage < totalPages
    }

    var onNavigate: ((HomeRoute) -> Void)?

    // MARK: - Dependencies
    private let loadHomeFirstPage: LoadHomeFirstPageUseCase
    private let loadHomeNextPage: LoadHomeNextPageUseCase

    // MARK: - Local states
    private var isLoadingFirst = false

    // client-driven pagination
    private var currentPage: Int = 1
    private var totalPages: Int = 1

    init(container: DIContainer) {
        self.loadHomeFirstPage = container.resolve(LoadHomeFirstPageUseCase.self)
        self.loadHomeNextPage = container.resolve(LoadHomeNextPageUseCase.self)
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
        defer { isLoadingFirst = false }

        do {
            let result = try await loadHomeFirstPage.execute()

            currentPage = 1
            totalPages = max(1, result.pagination.totalPages)

            let sections = result.sections
            if sections.isEmpty {
                state = .init(phase: .empty, sections: [], nextPage: nil)
                return
            }

            state = .init(
                phase: .content,
                sections: sections,
                nextPage: result.pagination.nextPage
            )
        } catch {
            state.phase = .error("Error, try again!")
        }
    }

    func loadNextPageIfNeeded() {
        guard case .content = state.phase else { return }
        guard !isPaginating else { return }
        guard currentPage < totalPages, let nextPage = state.nextPage else {
            return
        }

        let targetPage = currentPage + 1

        isPaginating = true

        Task {
            defer { isPaginating = false }
            do {
                let result = try await loadHomeNextPage.execute(path: nextPage)

                let fresh = result.sections
                if !fresh.isEmpty {
                    state.sections.append(contentsOf: fresh)
                }

                currentPage = targetPage
                state.nextPage = result.pagination.nextPage
            } catch {
                #if DEBUG
                print("❌ failed loading page \(targetPage): \(error)")
                #endif
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
