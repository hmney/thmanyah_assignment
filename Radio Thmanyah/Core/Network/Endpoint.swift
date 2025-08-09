//
//  Endpoint.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation
import Alamofire

public protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var encoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

public extension Endpoint {
    var baseURL: URL {
        URL(string: "https://api-v2-b2sit6oh3a-uc.a.run.app")!
    }

    var url: URL {
        baseURL.appendingPathComponent(path)
    }

    var parameters: Parameters? { nil }
    var encoding: ParameterEncoding { URLEncoding.default }
    var headers: HTTPHeaders? { nil }
}
