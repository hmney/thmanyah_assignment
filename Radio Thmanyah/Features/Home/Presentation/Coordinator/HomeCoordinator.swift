//
//  HomeCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

// Radio Thmanyah/Features/Home/Presentation/Coordinator/HomeCoordinator.swift
import SwiftUI

@MainActor
class HomeCoordinator: FlowCoordinator {
    let container: DIContainer
    var childCoordinator: (any Coordinator)?
    var onFinish: ((CoordinatorResult) -> Void)?
    var finishDelegate: CoordinatorFinishDelegate?
    private let _router = HomeRouter()
    var router: BaseRouter<HomeRoute> { _router }

    init(container: DIContainer) {
        self.container = container
    }

    func makeViewModel(container: DIContainer) -> HomeViewModel {
        return HomeViewModel(
            loadFirst: container.resolve(),
            loadNext: container.resolve()
        )
    }

    @ViewBuilder
    func buildContent() -> some View {
        HomeScreen()
    }
}
