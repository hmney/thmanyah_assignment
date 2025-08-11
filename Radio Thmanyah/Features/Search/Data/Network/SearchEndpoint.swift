//
//  SearchEndpoint.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


// Data/Search/Networking/SearchEndpoint.swift
import Foundation
import Alamofire

enum SearchEndpoint: Endpoint {
    case search(query: String)

    var baseURL: URL {
        URL(string: "https://mock.apidog.com")!
    }

    var method: HTTPMethod { .get }

    var path: String {
        switch self {
        case .search:
            return "m1/735111-711675-default/search"
        }
    }

    var parameters: Parameters? {
        switch self {
        case let .search(query):
            return ["": query]
        }
    }
}
