//
//  Eventually.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import XCTest

/// Polls until the condition becomes true or times out.
/// Avoids sleeps in tests that wait for async/Combine state updates.
@MainActor
func waitForCondition(
    timeout: TimeInterval = 5.0,
    interval: TimeInterval = 0.01,
    file: StaticString = #filePath,
    line: UInt = #line,
    condition: @escaping () -> Bool
) async {
    let startTime = Date()

    while Date().timeIntervalSince(startTime) < timeout {
        if condition() {
            return
        }

        await Task.yield()

        try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
    }

    XCTFail("Condition not met within \(timeout)s", file: file, line: line)
}
