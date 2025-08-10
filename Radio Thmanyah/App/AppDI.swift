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
        c.register(HomeRemoteDataSource.self) { c in
            HomeRemoteDataSourceImpl(client: c.resolve(), decoder: c.resolve())
        }
        c.register(HomeLocalDataSource.self) { _ in
            HomeLocalDataSourceImpl()
        }

        // Repository
        c.register(HomeRepository.self) { c in
            HomeRepositoryImpl(remote: c.resolve(), local: c.resolve())
        }

        // Use cases (scoped as factories so they’re lightweight)
        c.register(LoadHomeFirstPageUseCase.self, scopeSingleton: false) { c in
            LoadHomeFirstPageUseCase(repository: c.resolve())
        }
        c.register(LoadHomeNextPageUseCase.self, scopeSingleton: false) { c in
            LoadHomeNextPageUseCase(repository: c.resolve())
        }
    }
}
