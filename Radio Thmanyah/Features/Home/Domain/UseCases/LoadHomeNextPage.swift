//
//  LoadHomeNextPage.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

struct LoadHomeNextPage {
    private let repository: HomeRepository

    init(repository: HomeRepository) {
        self.repository = repository
    }

    func execute(path: String) async throws -> (sections: [HomeSection], pagination: Pagination) {
        return try await repository.loadNextPage(path: path)
    }
}
