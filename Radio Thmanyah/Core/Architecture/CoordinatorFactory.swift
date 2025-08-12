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
}

@MainActor
final class DefaultCoordinatorFactory: CoordinatorFactory {
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func makeHomeCoordinator() -> HomeCoordinator {
        HomeCoordinator(container: container)
    }
    
    func makeSearchCoordinator() -> SearchCoordinator {
        SearchCoordinator(container: container)
    }
}
