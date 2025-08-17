//
//  SearchDI.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


enum SearchDI {
    @MainActor
    static func register(in c: DIContainer) {
        // Data sources
        c.register(SearchRemoteDataSourceProtocol.self) { c in
            SearchRemoteDataSource(client: c.resolve(), decoder: c.resolve())
        }

        // Repository
        c.register(SearchRepositoryProtocol.self) { c in
            SearchRepository(remote: c.resolve())
        }

        // Use case (factory)
        c.register(SearchUseCaseProtocol.self, scopeSingleton: false) { c in
            SearchUseCase(repository: c.resolve())
        }
    }
}
