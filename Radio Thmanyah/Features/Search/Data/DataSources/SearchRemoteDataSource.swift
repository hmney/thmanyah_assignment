//
//  SearchRemoteDataSource.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


protocol SearchRemoteDataSource {
    func search(query: String) async throws -> SearchResponseDTO
}
