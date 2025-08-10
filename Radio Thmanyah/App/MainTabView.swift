//
//  MainTabView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var coordinator: AppCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                coordinator.getViewForTab(tab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .toolbar(.hidden, for: .tabBar)
                    .tag(tab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) {
            CustomTabBar(selectedTab: $coordinator.selectedTab)
                .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(.keyboard)
    }
}



//#Preview {
//    MainTabView()
//}
