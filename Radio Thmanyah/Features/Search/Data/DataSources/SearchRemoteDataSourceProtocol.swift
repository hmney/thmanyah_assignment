//
//  SearchRemoteDataSourceProtocol.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

protocol SearchRemoteDataSourceProtocol {
    func search(query: String) async throws -> SearchResponseDTO
}
