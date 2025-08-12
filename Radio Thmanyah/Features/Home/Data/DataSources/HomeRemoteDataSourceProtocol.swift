//
//  HomeRemoteDataSourceProtocol.swift.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

protocol HomeRemoteDataSourceProtocol {
    func fetchFirstPage() async throws -> HomeSectionsResponseDTO
    func fetchNextPage(pathOrURL: String) async throws -> HomeSectionsResponseDTO
}
