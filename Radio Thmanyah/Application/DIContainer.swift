//
//  DIContainer.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

final class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    lazy var apiClient: APIClientProtocol = APIClient()
    lazy var decoder: JSONDecoder =  {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601Flexible
        return decoder
    }()


    lazy var homeRepository: HomeRepository = HomeRepositoryImpl(
        apiClient: apiClient,
        decoder: decoder
    )
    
    // Use Cases
    lazy var loadHomeFirstPage = LoadHomeFirstPage(repository: homeRepository)
    lazy var loadHomeNextPage = LoadHomeNextPage(repository: homeRepository)

    @MainActor func makeHomeViewModel() -> HomeViewModel {
        return HomeViewModel(loadHomeFirstPage: loadHomeFirstPage, loadHomeNextPage: loadHomeNextPage)
    }

}
