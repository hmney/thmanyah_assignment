//
//  SearchCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

@MainActor
class SearchCoordinator: FlowCoordinator {
    let container: DIContainer
    var childCoordinator: (any Coordinator)?
    var onFinish: ((CoordinatorResult) -> Void)?
    var finishDelegate: CoordinatorFinishDelegate?

    private let _router = SearchRouter()
    var router: BaseRouter<SearchRoute> { _router }

    init(container: DIContainer) {
        self.container = container
    }

    func makeViewModel(container: DIContainer) -> SearchViewModel {
        return SearchViewModel(searchUseCase: container.resolve())
    }

    @ViewBuilder
    func buildContent() -> some View {
        SearchScreen()
    }
}
