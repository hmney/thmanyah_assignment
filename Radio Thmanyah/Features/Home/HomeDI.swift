//
//  HomeDI.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


// Radio Thmanyah/Features/Home/HomeDI.swift
enum HomeDI {
    @MainActor
    static func register(in c: DIContainer) {
        // Data sources
        c.register(HomeRemoteDataSourceProtocol.self) { c in
            HomeRemoteDataSource(client: c.resolve(), decoder: c.resolve())
        }
        c.register(HomeLocalDataSourceProtocol.self) { _ in
            HomeLocalDataSource()
        }

        // Repository
        c.register(HomeRepositoryProtocol.self) { c in
            HomeRepository(remote: c.resolve(), local: c.resolve())
        }

        // Use cases (factories)
        c.register(LoadHomeFirstPageUseCaseProtocol.self, scopeSingleton: false) { c in
            LoadHomeFirstPageUseCase(repository: c.resolve())
        }
        c.register(LoadHomeNextPageUseCaseProtocol.self, scopeSingleton: false) { c in
            LoadHomeNextPageUseCase(repository: c.resolve())
        }
    }
}
