//
//  CoordinatorStack.swift
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
 CoordinatorStack(
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
 CoordinatorStack(
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

struct CoordinatorStack<Route: BaseRoute, Content: View>: View {
    @ObservedObject var router: BaseRouter<Route>

    let container: DIContainer
    let content: () -> Content

    init(
        router: BaseRouter<Route>,
        container: DIContainer,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.router = router
        self.container = container
        self.content = content
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content()
                .navigationDestination(for: Route.self) { route in
                    router.destination(for: route)
                }
        }
        .sheet(isPresented: Binding(
            get: { router.sheet != nil },
            set: { if !$0 { router.dismissSheet() } }
        )) {
            if let r = router.sheet {
                router.sheetView(for: r)              
            } else {
                EmptyView()
            }
        }
        .fullScreenCover(isPresented: Binding(
            get: { router.fullScreenCover != nil },
            set: { if !$0 { router.dismissFull() } }
        )) {
            if let r = router.fullScreenCover {
                router.fullScreenView(for: r)
            } else {
                EmptyView()
            }
        }
    }
}
