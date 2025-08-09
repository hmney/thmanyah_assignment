//
//  Radio_ThmanyahApp.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import SwiftUI

@main
struct ThmanyahCloneApp: App {
    @StateObject private var homeViewModel: HomeViewModel = DIContainer.shared.makeHomeViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                AppTabBar()
                    .environment(\.colorScheme, .dark)
                    .environmentObject(homeViewModel)
            }
        }
    }
}
