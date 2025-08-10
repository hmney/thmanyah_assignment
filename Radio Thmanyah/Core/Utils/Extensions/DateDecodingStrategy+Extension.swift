//
//  JSONDecoder.DateDecodingStrategy.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

public extension JSONDecoder.DateDecodingStrategy {
    static var iso8601Flexible: JSONDecoder.DateDecodingStrategy {
        .custom { decoder in
            let s = try decoder.singleValueContainer().decode(String.self)
            let f = ISO8601DateFormatter()
            f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            if let d = f.date(from: s) { return d }
            f.formatOptions = [.withInternetDateTime]
            if let d = f.date(from: s) { return d }
            throw DecodingError.dataCorruptedError(in: try decoder.singleValueContainer(), debugDescription: "Invalid ISO8601 date: \(s)")
        }
    }
}
