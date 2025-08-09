//
//  HomeRepository.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

// HomeRepositoryImpl.swift
import Foundation

final class HomeRepositoryImpl: HomeRepository {
    private let remote: HomeRemoteDataSource

    init(remote: HomeRemoteDataSource) {
        self.remote = remote
    }

    func loadFirstPage() async throws -> (sections: [HomeSection], pagination: Pagination) {
        let dto = try await remote.fetchFirstPage()
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
}
