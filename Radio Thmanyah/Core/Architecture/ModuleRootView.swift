//
//  ModuleRootView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

struct ModuleRootView<Route: BaseRoute, Content: View>: View {
    @ObservedObject var router: BaseRouter<Route>
    let container: DIContainer
    let content: () -> Content
    let destinationBuilder: (Route) -> AnyView
    let sheetBuilder: (Route) -> AnyView?
    let fullScreenBuilder: (Route) -> AnyView?
    
    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content,
        destinationBuilder: @escaping (Route) -> AnyView,
        sheetBuilder: @escaping (Route) -> AnyView? = { _ in nil },
        fullScreenBuilder: @escaping (Route) -> AnyView? = { _ in nil }
    ) {
        self.router = router
        self.container = container
        self.content = content
        self.destinationBuilder = destinationBuilder
        self.sheetBuilder = sheetBuilder
        self.fullScreenBuilder = fullScreenBuilder
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Route.self) { route in
                    destinationBuilder(route)
                }
                .sheet(item: $router.sheet) { route in
                    sheetBuilder(route) ?? AnyView(EmptyView())
                }
                .fullScreenCover(item: $router.fullScreenCover) { route in
                    fullScreenBuilder(route) ?? AnyView(EmptyView())
                }
        }
        .environment(\.container, container)
    }
}
