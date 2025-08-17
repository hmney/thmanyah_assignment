//
//  CoordinatorHost.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


import SwiftUI

/// Reusable root: owns VM lifecycle, binds VM navigation to Router, injects DI container.
struct CoordinatorHost<Route: BaseRoute, VM: ViewModelProtocol & ObservableObject, Content: View>: View where VM.Route == Route {
    @StateObject private var viewModel: VM
    private let router: BaseRouter<Route>
    private let container: DIContainer
    private let content: () -> Content

    init(
        container: DIContainer,
        router: BaseRouter<Route>,
        makeViewModel: @escaping (DIContainer) -> VM,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.container = container
        self.router = router
        _viewModel = StateObject(wrappedValue: makeViewModel(container))
        self.content = content
    }

    var body: some View {
        CoordinatorStack(router: router, container: container, content: content)
            .environmentObject(viewModel)
            .environment(\.container, container)
            .onAppear {
                // Wire VM navigation intents to Router mutations
                viewModel.onNavigate = { [weak router] action in
                    switch action {
                    case .push(let r):        router?.push(r)
                    case .sheet(let r):       router?.presentSheet(r)
                    case .fullScreen(let r):  router?.presentFull(r)
                    case .pop:                router?.pop()
                    case .popToRoot:          router?.popToRoot()
                    case .dismissSheet:       router?.dismissSheet()
                    case .dismissFull:        router?.dismissFull()
                    }
                }
            }
    }
}
