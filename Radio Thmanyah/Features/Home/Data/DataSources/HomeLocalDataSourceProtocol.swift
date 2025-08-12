//
//  HomeLocalDataSourceProtocol.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation

protocol HomeLocalDataSourceProtocol {
    func saveFirstPage(_ data: CachedData) async throws
    func fetchFirstPage() async throws -> CachedData?
}
