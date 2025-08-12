//
//  AppRootView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//


import SwiftUI

struct AppRootView: View {
    let coordinator: AppCoordinator
    @ObservedObject var appViewModel: AppViewModel
    
    var body: some View {
        Group {
            if appViewModel.shouldShowSplashScreen {
                SplashScreen()
            } else {
                MainTabView(
                    coordinator: coordinator,
                    appViewModel: appViewModel
                )
            }
        }
        
        .alert("Network Error",
               isPresented: Binding(
                get: { appViewModel.networkStatus == .disconnected },
                set: { _ in }
               )
        ) {
            Button("OK") {}
        } message: {
            Text("Please check your internet connection")
        }
    }
}
