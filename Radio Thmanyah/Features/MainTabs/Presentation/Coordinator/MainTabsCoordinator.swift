//
//  MainTabsCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


import SwiftUI

@MainActor
final class MainTabsCoordinator: CompositionCoordinator {
    var childCoordinators: [any Coordinator] = []

    private let factory: CoordinatorFactory
    let container: DIContainer

    private let home: HomeCoordinator
    private let search: SearchCoordinator

    init(factory: CoordinatorFactory, container: DIContainer) {
        self.factory = factory
        self.container = container

        // Build children (each with its own feature-scoped container)
        self.home = factory.makeHomeCoordinator()
        self.search = factory.makeSearchCoordinator()

        // Track them in the composition list
        addChild(home)
        addChild(search)
    }

    func makeViewModel(container: DIContainer) -> MainTabsViewModel {
        return MainTabsViewModel(networkProvider: container.resolve())
    }

    @ViewBuilder
    func buildContent() -> some View {
        MainTabsRoot(home: self.home, search: self.search)
    }
}
