//
//  AppCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

@MainActor
final class AppCoordinator: CompositionCoordinator {
    var childCoordinators: [any Coordinator] = []

    private let factory: CoordinatorFactory
    let container: DIContainer

    private let mainTabsCoordinator: MainTabsCoordinator

    init(container: DIContainer) {
        self.container = container
        self.factory = DefaultCoordinatorFactory(container: container)

        // Setup child coordinators
        self.mainTabsCoordinator = factory.makeMainTabsCoordinator()
        addChild(mainTabsCoordinator)
    }

    func makeViewModel(container: DIContainer) -> AppViewModel {
        return AppViewModel()
    }

    @ViewBuilder
    func buildContent() -> some View {
        AppRootView(mainTabsCoordinator: self.mainTabsCoordinator)
    }
}
