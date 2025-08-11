//
//  LoadHomeFirstPageUseCase.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

struct LoadHomeFirstPageUseCase {
    private let repository: HomeRepositoryProtocol

    init(repository: HomeRepositoryProtocol) {
        self.repository = repository
    }

    func execute() async throws -> (sections: [HomeSection], pagination: Pagination) {
        let (sections, pagination) = try await repository.loadFirstPage()
        return (sections, pagination)
    }
}
