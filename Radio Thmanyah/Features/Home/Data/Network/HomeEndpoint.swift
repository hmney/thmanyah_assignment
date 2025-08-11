//
//  HomeEndpoint.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import Foundation
import Alamofire

enum HomeEndpoint: Endpoint {
    case firstPage
    /// Accepts either "/home_sections?page=2" OR an absolute URL
    case nextPage(path: String)

    // MARK: - Endpoint

    var baseURL: URL {
        URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app")!
    }
    
    var path: String {
        switch self {
        case .firstPage:
            return "home_sections"
        case .nextPage(let raw):
            let parsed = Self.parse(raw)
            // Fallback to "home_sections" if the path is empty
            return parsed.cleanPath.isEmpty ? "home_sections" : parsed.cleanPath
        }
    }

    var method: HTTPMethod { .get }

    var parameters: Parameters? {
        switch self {
        case .firstPage:
            return nil
        case .nextPage(let raw):
            let parsed = Self.parse(raw)
            var params: Parameters = [:]
            parsed.queryItems.forEach { item in
                if let v = item.value { params[item.name] = v }
            }
            return params.isEmpty ? nil : params
        }
    }

    /// Use URL query encoding so `?page=…&…` goes in the query, not path.
    var encoding: ParameterEncoding { URLEncoding.default }

    var headers: HTTPHeaders? { nil }
}

// MARK: - Helpers

private extension HomeEndpoint {
    /// Parses either a relative path like "/home_sections?page=2"
    /// or an absolute URL, returning a clean path and query items.
    static func parse(_ raw: String) -> (cleanPath: String, queryItems: [URLQueryItem]) {
        guard let comps = URLComponents(string: raw) else {
            // If it's just a bare path without "?", keep it as-is (trim leading "/")
            let trimmed = raw.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
            return (trimmed, [])
        }
        let path = comps.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let items = comps.queryItems ?? []
        return (path, items)
    }
}
