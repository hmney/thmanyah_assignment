//
//  DateDecodingStrategyTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

private struct D: Decodable { let d: Date }

final class DateDecodingStrategyTests: XCTestCase {
    func test_decodes_iso8601_withFractionalSeconds() throws {
        let json = #"{"d":"2017-10-23T06:19:00.000Z"}"#.data(using: .utf8)!
        let dec = JSONDecoder(); dec.dateDecodingStrategy = .iso8601Flexible
        XCTAssertNoThrow(try dec.decode(D.self, from: json))
    }

    func test_decodes_iso8601_withoutFractionalSeconds() throws {
        let json = #"{"d":"2023-01-10T08:00:00Z"}"#.data(using: .utf8)!
        let dec = JSONDecoder(); dec.dateDecodingStrategy = .iso8601Flexible
        XCTAssertNoThrow(try dec.decode(D.self, from: json))
    }
}
