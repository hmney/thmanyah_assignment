//
//  HomeRepository.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

final class HomeRepository: HomeRepositoryProtocol {
    private let remote: HomeRemoteDataSource
    private let local: HomeLocalDataSource
    private let cacheExpirationInterval: TimeInterval = 60 * 5 // 5 minutes

    init(remote: HomeRemoteDataSource, local: HomeLocalDataSource) {
        self.remote = remote
        self.local = local
    }

    func loadFirstPage() async throws -> (sections: [HomeSection], pagination: Pagination) {
        if let cachedData = try await local.fetchFirstPage(), !isCacheExpired(cachedData) {
            print("Loading from cache.")
            return map(cachedData.dto)
        }
        let dto = try await remote.fetchFirstPage()
        let freshCachedData = CachedData(dto: dto, timestamp: Date())
        try await local.saveFirstPage(freshCachedData)
        return map(dto)
    }

    func loadNextPage(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) {
        let dto = try await remote.fetchNextPage(pathOrURL: path)
        return map(dto)
    }

    // MARK: - Mapping

    private func map(_ dto: HomeSectionsResponseDTO) -> ([HomeSection], Pagination) {
        let mappedSections = dto.sections.map { HomeMapper.mapHomeSections(sectionDTO: $0) }
        let mappedPagination = HomeMapper.mapPagination(paginationDTO: dto.pagination)
        return (mappedSections, mappedPagination)
    }

    private func isCacheExpired(_ cachedData: CachedData) -> Bool {
        return Date().timeIntervalSince(cachedData.timestamp) > cacheExpirationInterval
    }
}
