//
//  TestDecoder.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation
import Radio_Thmanyah

enum TestDecoder {
    static func make() -> JSONDecoder {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .iso8601Flexible
        return d
    }
}
