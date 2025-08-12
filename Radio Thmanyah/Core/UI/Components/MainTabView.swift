//
//  MainTabView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import SwiftUI

struct MainTabView: View {
    let coordinator: AppCoordinator
    @ObservedObject var appViewModel: AppViewModel

    var body: some View {
        TabView(selection: $appViewModel.selectedTab) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                coordinator.viewForTab(tab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(tab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $appViewModel.selectedTab)
                .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(.keyboard)
        .disabled(appViewModel.networkStatus == .disconnected && requiresNetwork(appViewModel.selectedTab))
    }

    private func requiresNetwork(_ tab: AppTab) -> Bool {
        switch tab {
        case .home, .search:
            return true
        case .library, .settings, .square:
            return false
        }
    }
}
