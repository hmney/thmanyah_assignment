//
//  HomeRemoteDataSource.swift.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

protocol HomeRemoteDataSource {
    func fetchFirstPage() async throws -> HomeSectionsResponseDTO
    func fetchNextPage(pathOrURL: String) async throws -> HomeSectionsResponseDTO
}
