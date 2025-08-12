//
//  HasNotchKey.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//


import SwiftUI

private struct HasNotchKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

extension EnvironmentValues {
    var hasNotch: Bool {
        get { self[HasNotchKey.self] }
        set { self[HasNotchKey.self] = newValue }
    }
}
