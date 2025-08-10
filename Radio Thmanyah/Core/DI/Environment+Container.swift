//
//  ContainerKey.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

private struct ContainerKey: EnvironmentKey {
    @MainActor
    static var defaultValue: DIContainer = .init()
}

extension EnvironmentValues {
    var container: DIContainer {
        get { self[ContainerKey.self] }
        set { self[ContainerKey.self] = newValue }
    }
}
