//
//  MainTabsRoot.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//

import SwiftUI

struct MainTabsRoot: View {
    @EnvironmentObject var viewModel: MainTabsViewModel

    let home: HomeCoordinator
    let search: SearchCoordinator

    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            home.start()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar(.hidden, for: .tabBar)
                .tag(AppTab.home)

            search.start()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .toolbar(.hidden, for: .tabBar)
                .tag(AppTab.search)

            Text("Square Coming Soon").tag(AppTab.square)
            Text("Library Coming Soon").tag(AppTab.library)
            Text("Settings Coming Soon").tag(AppTab.settings)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $viewModel.selectedTab)
                .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(.keyboard)
        .disabled(viewModel.networkStatus == .disconnected &&
                  viewModel.requiresNetwork(viewModel.selectedTab))
        .alert("Network Error",
               isPresented: .constant(viewModel.networkStatus == .disconnected)) {
            Button("OK") {}
        } message: {
            Text("Please check your internet connection")
        }
    }
}

