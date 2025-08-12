//
//  AppCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

@MainActor
final class AppCoordinator: Coordinator {
    private let coordinatorManager: CoordinatorManager
    private let appViewModel: AppViewModel

    @MainActor
    init(container: DIContainer) {
        let factory = DefaultCoordinatorFactory(container: container)
        self.coordinatorManager = CoordinatorManager(factory: factory)
        self.appViewModel = AppViewModel()

        appViewModel.appDidLaunch()
    }

    func start() -> some View {
        AppRootView(
            coordinator: self,
            appViewModel: appViewModel
        )
    }

    @ViewBuilder
    func viewForTab(_ tab: AppTab) -> some View {
        switch tab {
        case .home:
            if let coordinator = coordinatorManager.coordinator(for: tab, type: HomeCoordinator.self) {
                coordinator.start()
            } else {
                Text("Error loading Home")
            }

        case .search:
            if let coordinator = coordinatorManager.coordinator(for: tab, type: SearchCoordinator.self) {
                coordinator.start()
            } else {
                Text("Error loading Search")
            }

        case .square:
            Text("Square Coming Soon")

        case .library:
            Text("Library Coming Soon")

        case .settings:
            Text("Settings Coming Soon")
        }
    }

    // Memory management
    func cleanup() {
        coordinatorManager.releaseAllCoordinators()
    }
}
