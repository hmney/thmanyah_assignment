//
//  HomeRepository.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

final class HomeRepositoryImpl: HomeRepository {
    private let apiClient: APIClientProtocol
    private let decoder: JSONDecoder
    private let baseURL = URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app")!

    init(apiClient: APIClientProtocol, decoder: JSONDecoder) {
        self.apiClient = apiClient
        self.decoder = decoder
    }

    func loadFirstPage() async throws -> (sections: [HomeSection], pagination: Pagination) {
        let url = baseURL.appendingPathComponent("home_sections")
        return try await fetch(url: url)
    }

    func loadNextPage(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) {
        // API returns e.g. "/home_sections?page=2"
        let url: URL
        if let absolute = URL(string: path), absolute.scheme != nil {
            url = absolute
        } else {
            // treat it as relative to base
            url = URL(string: path, relativeTo: baseURL)?.absoluteURL ?? baseURL
        }
        return try await fetch(url: url)
    }

    // MARK: - Private
    private func fetch(url: URL) async throws -> (sections: [HomeSection], pagination: Pagination) {
        let endpoint = Endpoint(path: url.absoluteString)
        let data: Data = try await apiClient.getRaw(endpoint)
        let dto = try decoder.decode(HomeSectionsResponseDTO.self, from: data)
        let mappedSections = dto.sections.map { HomeMapper.mapHomeSections(sectionDTO: $0) }
        let mappedPagination = HomeMapper.mapPagination(paginationDTO: dto.pagination)
        return (mappedSections, mappedPagination)
    }
}
