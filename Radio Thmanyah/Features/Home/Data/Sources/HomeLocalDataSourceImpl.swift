//
//  HomeLocalDataSourceImpl.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation

final class HomeLocalDataSourceImpl: HomeLocalDataSource {
    private let userDefaults: UserDefaults
    private static let cacheKey = "homeFirstPageCache"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func saveFirstPage(_ data: CachedData) async throws {
        let encoder = JSONEncoder()
        let encodedData = try encoder.encode(data)
        userDefaults.set(encodedData, forKey: Self.cacheKey)
    }

    func fetchFirstPage() async throws -> CachedData? {
        guard let encodedData = userDefaults.data(forKey: Self.cacheKey) else {
            return nil
        }
        let decoder = JSONDecoder()
        let cachedData = try decoder.decode(CachedData.self, from: encodedData)
        return cachedData
    }
}
