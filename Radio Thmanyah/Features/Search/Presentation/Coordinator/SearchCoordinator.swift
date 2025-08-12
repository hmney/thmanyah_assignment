//
//  SearchCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

@MainActor
final class SearchCoordinator: Coordinator {
    private let container: DIContainer
    private let router = SearchRouter()
    private(set) var viewModel: SearchViewModel

    init(container: DIContainer) {
        self.container = container
        self.viewModel = SearchViewModel(container: container)
    }

    func start() -> some View {
        ModuleRootView(
            router: router,
            container: container,
            content: {
                SearchScreen(viewModel: self.viewModel)
            }
        )
    }
}
