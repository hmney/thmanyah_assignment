//
//  FlowCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//

import SwiftUI

@MainActor
protocol FlowCoordinator: Coordinator, FinishableCoordinator, CoordinatorFinishDelegate {
    associatedtype Route: BaseRoute
    associatedtype VM: ViewModelProtocol & ObservableObject where VM.Route == Route
    associatedtype Content: View

    var container: DIContainer { get }
    var router: BaseRouter<Route> { get }
    var childCoordinator: (any Coordinator)? { get set }

    func makeViewModel(container: DIContainer) -> VM
    @ViewBuilder func buildContent() -> Content
    
}

extension FlowCoordinator {
    func start() -> some View {
        CoordinatorHost(
            container: container,
            router: router,
            makeViewModel: makeViewModel,
            content: buildContent
        )
    }

    func addChild(_ coordinator: any Coordinator) {
        childCoordinator = coordinator
        if let finishableChild = coordinator as? any FinishableCoordinator {
            finishableChild.finishDelegate = self
        }
    }

    func removeChild() {
        childCoordinator = nil
    }

    // CoordinatorFinishDelegate implementation
    func coordinatorDidFinish(_ coordinator: AnyObject, result: CoordinatorResult) {
        removeChild()
    }
}
