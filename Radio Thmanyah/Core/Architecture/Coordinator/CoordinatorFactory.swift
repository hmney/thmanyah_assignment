//
//  CoordinatorFactory.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//

import Foundation

@MainActor
protocol CoordinatorFactory {
    func makeHomeCoordinator() -> HomeCoordinator
    func makeSearchCoordinator() -> SearchCoordinator
    func makeMainTabsCoordinator() -> MainTabsCoordinator
}

@MainActor
final class DefaultCoordinatorFactory: CoordinatorFactory {
    private let container: DIContainer

    init(container: DIContainer) { self.container = container }

    func makeHomeCoordinator() -> HomeCoordinator {
        let feature = container.child { HomeDI.register(in: $0) }
        return HomeCoordinator(container: feature)
    }

    func makeSearchCoordinator() -> SearchCoordinator {
        let feature = container.child { SearchDI.register(in: $0) }
        return SearchCoordinator(container: feature)
    }

    func makeMainTabsCoordinator() -> MainTabsCoordinator {
        return MainTabsCoordinator(factory: self, container: container)
    }
}
