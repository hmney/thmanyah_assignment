//
//  HomeRepository.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

protocol HomeRepository {
    func loadFirstPage() async throws -> (sections: [HomeSection], pagination: Pagination)
    func loadNextPage(path: String) async throws -> (sections: [HomeSection], pagination: Pagination)
}
