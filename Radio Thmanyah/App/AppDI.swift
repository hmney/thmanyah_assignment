//
//  AppDI.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Alamofire
import Foundation

enum AppDI {
    
    @MainActor
    static func register(in c: DIContainer) {
        // Core
        c.register(Session.self) { _ in
            let config = URLSessionConfiguration.default
            config.waitsForConnectivity = true
            config.timeoutIntervalForRequest = 20
            config.timeoutIntervalForResource = 40
            return Session(configuration: config)
        }

        c.register(NetworkClient.self) { c in
            AlamofireNetworkClient(session: c.resolve())
        }

        c.register(JSONDecoder.self) { _ in
            let d = JSONDecoder()
            d.dateDecodingStrategy = .iso8601Flexible
            d.keyDecodingStrategy = .useDefaultKeys
            return d
        }

        c.register(NetworkStatusProviding.self) { _ in
            DefaultNetworkStatusProvider()
        }
    }
}
