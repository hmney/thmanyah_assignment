//
//  HomeCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

@MainActor
final class HomeCoordinator: Coordinator {
    private let container: DIContainer
    private let router = HomeRouter()
    private(set) var viewModel: HomeViewModel

    init(container: DIContainer) {
        self.container = container
        self.viewModel = HomeViewModel(container: container)

        viewModel.onNavigate = { [weak self] request in
            self?.handle(request)
        }
    }

    func start() -> some View {
        ModuleRootView(
            router: router,
            container: container,
            content: {
                HomeScreen(viewModel: self.viewModel)
            },
            destinationBuilder: buildDestination
        )
    }

    private func handle(_ route: HomeRoute) {
        switch route {
        case .section(let data):
            router.toSection(section: data)
        }
    }

    @ViewBuilder
    private func buildDestination(for route: HomeRoute) -> some View {
        switch route {
        case .section(let data): SectionListScreen(section: data)
        }
    }
}
