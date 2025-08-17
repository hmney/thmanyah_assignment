//
//  AppRootView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//


import SwiftUI

struct AppRootView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    let mainTabsCoordinator: MainTabsCoordinator

    var body: some View {
        Group {
            if appViewModel.shouldShowSplashScreen {
                SplashScreen()
                    .transition(.opacity)
            } else {
                mainTabsCoordinator.start()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 1), value: appViewModel.shouldShowSplashScreen)
        .onAppear {
            appViewModel.appDidLaunch()
        }
    }
}
