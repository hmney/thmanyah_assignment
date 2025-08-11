//
//  AppCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

@MainActor
final class AppCoordinator: ObservableObject, Coordinator {
    let container: DIContainer
    
    private var tabCoordinators: [AppTab: Any] = [:]
    private var cachedViews: [AppTab: AnyView] = [:]
    
    @Published var selectedTab: AppTab = .home
    @Published private var shouldShowSplashScreen: Bool = true

    init(container: DIContainer) {
        self.container = container
        startSplashTimer()
    }
    
    func start() -> some View {
        Group {
            if shouldShowSplashScreen {
                SplashScreen()
            } else {
                MainTabView(coordinator: self)
            }
        }
    }
    
    func getViewForTab(_ tab: AppTab) -> AnyView {
        if let cachedView = cachedViews[tab] {
            return cachedView
        }
        
        let view = createViewForTab(tab)
        cachedViews[tab] = view
        return view
    }
    
    private func createViewForTab(_ tab: AppTab) -> AnyView {
        switch tab {
        case .home:
            let coordinator = HomeCoordinator(container: container)
            tabCoordinators[tab] = coordinator
            return AnyView(coordinator.start())
            
        case .search:
            let coordinator = SearchCoordinator(container: container)
            tabCoordinators[tab] = coordinator
            return AnyView(coordinator.start())

        case .square:
            return AnyView(Text("Square Coming Soon"))

        case .library:
            return AnyView(Text("Libray Coming Soon"))

        case .settings:
            return AnyView(Text("Settings Coming Soon"))
        }
    }
    
    private func startSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.shouldShowSplashScreen = false
        }
    }
}
