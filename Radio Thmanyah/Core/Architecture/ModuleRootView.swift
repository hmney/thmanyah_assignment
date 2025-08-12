//
//  ModuleRootView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

/**
 A generic root view for module-based navigation using SwiftUI's NavigationStack.

 This view provides a type-safe alternative to `AnyView` by using generic type parameters
 for different navigation destinations. It forces implementers to provide proper builder
 functions for navigation, sheets, and full-screen presentations.

 ## Usage

 ```swift
 // Define your routes
 enum MyAppRoute: BaseRoute {
     case profile
     case settings
     case modal
     case onboarding
 }

 // Create the root view in your coordinator
 struct MyCoordinator {
     func createRootView() -> some View {
         ModuleRootView(
             router: myRouter,
             container: myContainer,
             content: {
                 HomeView()
             },
             destinationBuilder: { route in
                 switch route {
                 case .profile:
                     ProfileView()
                 case .settings:
                     SettingsView()
                 }
             },
             sheetBuilder: { route in
                 switch route {
                 case .modal:
                     ModalView()
                 default:
                     nil
                 }
             },
             fullScreenBuilder: { route in
                 switch route {
                 case .onboarding:
                     OnboardingView()
                 default:
                     nil
                 }
             }
         )
     }
 }
 ```

 ## Simplified Usage

 For cases where you only need basic navigation without sheets or full-screen covers:

 ```swift
 ModuleRootView(
     router: myRouter,
     container: myContainer,
     content: {
         HomeView()
     },
     destinationBuilder: { route in
         switch route {
         case .profile: ProfileView()
         case .settings: SettingsView()
         }
     }
 )
 ```

 ## Generic Parameters

 - `Route`: The route type conforming to `BaseRoute`
 - `Content`: The type of the initial/root view content
 - `Destination`: The type returned by `destinationBuilder`
 - `Sheet`: The type returned by `sheetBuilder`
 - `FullScreen`: The type returned by `fullScreenBuilder`
 */

struct ModuleRootView<
    Route: BaseRoute,
    Content: View,
    Destination: View,
    Sheet: View,
    FullScreen: View
>: View {
    @ObservedObject var router: BaseRouter<Route>
    let container: DIContainer
    let content: () -> Content
    let destinationBuilder: (Route) -> Destination?
    let sheetBuilder: (Route) -> Sheet?
    let fullScreenBuilder: (Route) -> FullScreen?

    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder destinationBuilder: @escaping (Route) -> Destination? = { _ in nil },
        @ViewBuilder sheetBuilder: @escaping (Route) -> Sheet? = { _ in nil },
        @ViewBuilder fullScreenBuilder: @escaping (Route) -> FullScreen? = { _ in nil }
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
                    if let destinationView = destinationBuilder(route) {
                        destinationView
                    } else {
                        EmptyView()
                    }
                }
                .sheet(item: $router.sheet) { route in
                    if let sheetView = sheetBuilder(route) {
                        sheetView
                    } else {
                        EmptyView()
                    }
                }
                .fullScreenCover(item: $router.fullScreenCover) { route in
                    if let fullScreenView = fullScreenBuilder(route) {
                        fullScreenView
                    } else {
                        EmptyView()
                    }
                }
        }
        .environment(\.container, container)
    }
}

// MARK: - Convenience initializers for cases where you don't need all builders

extension ModuleRootView where Destination == EmptyView, Sheet == EmptyView, FullScreen == EmptyView {
    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.init(
            router: router,
            container: container,
            content: content,
            destinationBuilder: { _ in EmptyView() },
            sheetBuilder: { _ in EmptyView() },
            fullScreenBuilder: { _ in EmptyView() }
        )
    }
}

extension ModuleRootView where Sheet == EmptyView, FullScreen == EmptyView {
    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder destinationBuilder: @escaping (Route) -> Destination
    ) {
        self.init(
            router: router,
            container: container,
            content: content,
            destinationBuilder: destinationBuilder,
            sheetBuilder: { _ in EmptyView() },
            fullScreenBuilder: { _ in EmptyView() }
        )
    }
}

extension ModuleRootView where Sheet == EmptyView {
    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder destinationBuilder: @escaping (Route) -> Destination,
        @ViewBuilder fullScreenBuilder: @escaping (Route) -> FullScreen?
    ) {
        self.init(
            router: router,
            container: container,
            content: content,
            destinationBuilder: destinationBuilder,
            sheetBuilder: { _ in EmptyView() },
            fullScreenBuilder: fullScreenBuilder
        )
    }
}

extension ModuleRootView where FullScreen == EmptyView {
    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder destinationBuilder: @escaping (Route) -> Destination,
        @ViewBuilder sheetBuilder: @escaping (Route) -> Sheet?
    ) {
        self.init(
            router: router,
            container: container,
            content: content,
            destinationBuilder: destinationBuilder,
            sheetBuilder: sheetBuilder,
            fullScreenBuilder: { _ in EmptyView() }
        )
    }
}
