//
//  Endpoint.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]

    init(path: String, queryItems: [URLQueryItem] = []) {
        self.path = path
        self.queryItems = queryItems
    }

    var url: URL {
        var components = URLComponents(string: path)!
        if !queryItems.isEmpty {
            components.queryItems = queryItems
        }
        return components.url!
    }
}
