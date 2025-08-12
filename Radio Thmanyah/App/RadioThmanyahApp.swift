//
//  Radio_ThmanyahApp.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import SwiftUI

@main
struct RadioThmanyahApp: App {
    private let appCoordinator: AppCoordinator

    init() {
        let appContainer = DIContainer()
        AppDI.register(in: appContainer)

        self.appCoordinator = AppCoordinator(container: appContainer)
    }

    var body: some Scene {
        WindowGroup {
            appCoordinator.start()
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willTerminateNotification)) { _ in
                    appCoordinator.cleanup()
                }
        }
    }
}
