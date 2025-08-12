//
//  AppViewModel.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//

import SwiftUI
import Combine

@MainActor
final class AppViewModel: ObservableObject {
    @Published var selectedTab: AppTab = .home
    @Published var appState: AppState = .launching
    @Published var networkStatus: NetworkStatus = .unknown

    private var cancellables = Set<AnyCancellable>()
    private let minimumSplashDuration: TimeInterval = 2.0

    init() { }

    var shouldShowSplashScreen: Bool {
        appState == .launching
    }

    // MARK: - App Lifecycle
    func appDidLaunch() {
        guard appState == .launching else { return }

        print("🚀 App launch started")

        Task { @MainActor in
            let startTime = Date()

            await performStartupTasks()
            let taskDuration = Date().timeIntervalSince(startTime)
            print("⏱️ Startup tasks completed in \(taskDuration)s")

            let remainingTime = max(0, minimumSplashDuration - taskDuration)
            if remainingTime > 0 {
                print("⏳ Waiting additional \(remainingTime)s for minimum splash duration")
                try? await Task.sleep(nanoseconds: UInt64(remainingTime * 1_000_000_000))
            }

            print("✨ App ready - hiding splash")
            appState = .ready

            setupAppStateObservers()
        }
    }

    // MARK: - Navigation Actions
    func selectTab(_ tab: AppTab) {
        selectedTab = tab
    }
    
    // MARK: - Private Methods
    private func setupAppStateObservers() {
        NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)
            .sink { [weak self] _ in
                self?.appState = .backgrounded
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.appState = .ready
            }
            .store(in: &cancellables)
    }
    
    private func performStartupTasks() async {
        // Simulate startup tasks
        try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds
        
        // Load user session, check connectivity, etc.
        // - Check authentication status
        // - Load cached data  
        // - Initialize analytics
        // - Check for app updates
    }
}

extension AppViewModel {
    enum AppState {
        case launching
        case ready
        case backgrounded
    }

    enum NetworkStatus {
        case unknown
        case connected
        case disconnected
    }
}
