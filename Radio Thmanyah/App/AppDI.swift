//
//  AppDI.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Alamofire
import Foundation

enum AppDI {
    
    @MainActor
    static func register(in c: DIContainer) {
        // Core
        c.register(Session.self) { _ in
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForRequest = 20
            config.timeoutIntervalForResource = 40
            return Session(configuration: config)
        }

        c.register(NetworkClient.self) { c in
            AlamofireNetworkClient(session: c.resolve())
        }

        c.register(JSONDecoder.self) { _ in
            let d = JSONDecoder()
            d.dateDecodingStrategy = .iso8601Flexible
            d.keyDecodingStrategy = .useDefaultKeys
            return d
        }

        // Data sources
        c.register(HomeRemoteDataSourceProtocol.self) { c in
            HomeRemoteDataSource(
                client: c.resolve(),
                decoder: c.resolve()
            )
        }
        c.register(HomeLocalDataSourceProtocol.self) { _ in
            HomeLocalDataSource()
        }
        c.register(SearchRemoteDataSourceProtocol.self) { c in
            SearchRemoteDataSource(
                client: c.resolve(),
                decoder: c.resolve()
            )
        }

        // Repository
        c.register(HomeRepositoryProtocol.self) { c in
            HomeRepository(remote: c.resolve(), local: c.resolve())
        }
        c.register(SearchRepositoryProtocol.self) { c in
            SearchRepository(remote: c.resolve())
        }

        // Use cases (scoped as factories so they’re lightweight)
        c.register(LoadHomeFirstPageUseCaseProtocol.self, scopeSingleton: false) { c in
            LoadHomeFirstPageUseCase(repository: c.resolve())
        }
        c.register(LoadHomeNextPageUseCaseProtocol.self, scopeSingleton: false) { c in
            LoadHomeNextPageUseCase(repository: c.resolve())
        }
        c.register(SearchUseCaseProtocol.self, scopeSingleton: false) { c in
            SearchUseCase(repository: c.resolve())
        }
    }
}
