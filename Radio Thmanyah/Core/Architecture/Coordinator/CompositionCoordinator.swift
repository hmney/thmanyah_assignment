//
//  CompositionCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//

import SwiftUI

@MainActor
protocol CompositionCoordinator: Coordinator {
    associatedtype Route: BaseRoute
    associatedtype VM: ViewModelProtocol & ObservableObject where VM.Route == Route
    associatedtype Content: View

    var childCoordinators: [any Coordinator] { get set }
    var container: DIContainer { get }

    func makeViewModel(container: DIContainer) -> VM
    @ViewBuilder func buildContent() -> Content

    func addChild(_ coordinator: any Coordinator)
    func removeChild(_ coordinator: any Coordinator)
    func removeAllChildren()
}

extension CompositionCoordinator {
    func start() -> some View {
        CompositionHost(
            container: container,
            makeViewModel: makeViewModel,
            content: buildContent
        )
    }

    func addChild(_ coordinator: any Coordinator) {
        childCoordinators.append(coordinator)
    }

    func removeChild(_ coordinator: any Coordinator) {
        let target = ObjectIdentifier(coordinator as AnyObject)
        childCoordinators.removeAll { ObjectIdentifier($0 as AnyObject) == target }
    }

    func removeAllChildren() {
        childCoordinators.removeAll()
    }
}
