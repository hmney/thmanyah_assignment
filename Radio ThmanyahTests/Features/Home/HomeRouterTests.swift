//
//  HomeRouterTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


// Radio ThmanyahTests/Features/Home/HomeRouterTests.swift
import XCTest
@testable import Radio_Thmanyah

@MainActor
final class HomeRouterTests: XCTestCase {
    func testConvenienceAPIsPushCorrectRoutes() {
        let router = HomeRouter()
        let section = HomeSection(title: "Section Title", displayStyle: .bigSquare, contentKind: .episode(""), order: 1, items: [])
        router.toSection(section: section)
        XCTAssertEqual(router.path.count, 1)
    }
}
