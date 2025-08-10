//
//  DIContainer.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation
import Alamofire

final class DIContainer {
    static let shared = DIContainer()
    private init() {}

    // MARK: - Core
    lazy var session: Session = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 20
        config.timeoutIntervalForResource = 40
        return Session(configuration: config)
    }()

    lazy var client: NetworkClient = AlamofireNetworkClient(session: session)

    lazy var decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601Flexible
        d.keyDecodingStrategy = .useDefaultKeys
        return d
    }()


    // MARK: - Data Sources
    lazy var homeRemoteDataSource: HomeRemoteDataSource = HomeRemoteDataSourceImpl(
        client: client,
        decoder: decoder
    )

    lazy var localRemoteDataSource: HomeLocalDataSource = HomeLocalDataSourceImpl()

    // MARK: - Repositories
    lazy var homeRepository: HomeRepository = HomeRepositoryImpl(
        remote: homeRemoteDataSource,
        local: localRemoteDataSource
    )

    // MARK: - Use Cases
    lazy var loadHomeFirstPage = LoadHomeFirstPageUseCase(repository: homeRepository)
    lazy var loadHomeNextPage  = LoadHomeNextPageUseCase(repository: homeRepository)

    // MARK: - ViewModels
    @MainActor
    func makeHomeViewModel() -> HomeViewModel {
        HomeViewModel(
            loadHomeFirstPage: loadHomeFirstPage,
            loadHomeNextPage: loadHomeNextPage
        )
    }
}
