//
//  HomeCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

@MainActor
final class HomeCoordinator: ObservableObject, Coordinator {
    private let container: DIContainer
    private let router = HomeRouter()
    
    @Published private(set) var viewModel: HomeViewModel

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
            destinationBuilder: buildDestination,
            sheetBuilder: buildSheet,
            fullScreenBuilder: buildFullScreen
        )
    }

    private func handle(_ route: HomeRoute) {
        switch route {
        case .section(let data):
            router.toSection(section: data)
        }
    }

    private func buildDestination(for route: HomeRoute) -> AnyView {
        switch route {
        case .section(let data): AnyView(SectionListScreen(section: data))
        }
    }

    private func buildSheet(for route: HomeRoute) -> AnyView {
        switch route {
            // Add Destination views here
        default :
            fatalError("Unsupported route: \(route)")
        }
    }

    private func buildFullScreen(for route: HomeRoute) -> AnyView {
        switch route {
            // Add Destination views here
        default :
            fatalError("Unsupported route: \(route)")
        }
    }
}
