//
//  SearchRepositoryProtocol.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

protocol SearchRepositoryProtocol {
    func search(query: String) async throws -> SearchResponse
}
