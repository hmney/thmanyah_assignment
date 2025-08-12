//
//  DIContainerTests.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//


import XCTest
@testable import Radio_Thmanyah

@MainActor
final class DIContainerTests: XCTestCase {
    func test_registerResolve_singletonByDefault() {
        let c = DIContainer()
        class Foo { }
        c.register(Foo.self) { _ in Foo() }

        let a: Foo = c.resolve()
        let b: Foo = c.resolve()
        XCTAssertTrue(a === b, "Should resolve same singleton instance")
    }

    func test_child_overridesFactory() {
        let root = DIContainer()
        class Bar { let id = UUID() }
        root.register(Bar.self) { _ in Bar() }

        let child = root.child { child in
            child.register(Bar.self) { _ in Bar() }
        }

        let a: Bar = root.resolve()
        let b: Bar = child.resolve()
        XCTAssertTrue(a !== b, "Child should override and produce different instance")
    }
}
