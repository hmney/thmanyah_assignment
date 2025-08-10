//
//  Radio_ThmanyahApp.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import SwiftUI

@main
struct ThmanyahCloneApp: App {
    @StateObject private var appCoordinator: AppCoordinator

    @MainActor
    init() {
        let appContainer = DIContainer()
        AppDI.register(in: appContainer)
        _appCoordinator = StateObject(wrappedValue: AppCoordinator(container: appContainer))
    }

    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
                .environment(\.container, appCoordinator.container)
        }
    }
}
