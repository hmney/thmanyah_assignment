//
//  SearchCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

@MainActor
final class SearchCoordinator: ObservableObject, Coordinator {
    private let container: DIContainer
    private let router = SearchRouter()

    @Published private(set) var viewModel: SearchViewModel

    init(container: DIContainer) {
        self.container = container
        self.viewModel = SearchViewModel(container: container)

        viewModel.onNavigate = { [weak self] request in
            self?.handle(request)
        }
    }

    func start() -> some View {
        ModuleRootView(
            router: router,
            container: container,
            content: {
                SearchScreen(viewModel: self.viewModel)
            },
            destinationBuilder: buildDestination,
            sheetBuilder: buildSheet,
            fullScreenBuilder: buildFullScreen
        )
    }

    private func handle(_ route: SearchRoute) {
        switch route {
        default :
            fatalError("Unsupported route: \(route)")
        }
    }

    private func buildDestination(for route: SearchRoute) -> AnyView {
        switch route {
        default :
            fatalError("Unsupported route: \(route)")
        }
    }

    private func buildSheet(for route: SearchRoute) -> AnyView {
        switch route {
            // Add Destination views here
        default :
            fatalError("Unsupported route: \(route)")
        }
    }

    private func buildFullScreen(for route: SearchRoute) -> AnyView {
        switch route {
            // Add Destination views here
        default :
            fatalError("Unsupported route: \(route)")
        }
    }
}
