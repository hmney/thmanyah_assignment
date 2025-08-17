//
//  BaseRouterTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//

import XCTest
@testable import Radio_Thmanyah

private enum TestRoute: BaseRoute { case a, b }

@MainActor
final class BaseRouterTests: XCTestCase {
    func testPushPop() {
        let r = BaseRouter<TestRoute>()
        r.push(.a); r.push(.b)
        XCTAssertEqual(r.path.count, 2)
        r.pop()
        XCTAssertEqual(r.path, [.a])
        r.popToRoot()
        XCTAssertTrue(r.path.isEmpty)
    }

    func testSheetAndFullScreenFlags() {
        let r = BaseRouter<TestRoute>()
        r.presentSheet(.a)
        XCTAssertEqual(r.sheet, .a)
        r.dismissSheet()
        XCTAssertNil(r.sheet)

        r.presentFull(.b)
        XCTAssertEqual(r.fullScreenCover, .b)
        r.dismissFull()
        XCTAssertNil(r.fullScreenCover)
    }

    func testDefaultBuildersReturnAnyView() {
        let r = BaseRouter<TestRoute>()
        _ = r.destination(for: .a)
        _ = r.sheetView(for: .a)
        _ = r.fullScreenView(for: .a)
        // If it didn't crash, we're good.
    }
}
