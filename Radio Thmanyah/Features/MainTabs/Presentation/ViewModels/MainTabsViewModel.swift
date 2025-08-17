//
//  MainTabsViewModel.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//


// Features/MainTabs/Presentation/ViewModels/MainTabsViewModel.swift
import Combine
import SwiftUI

@MainActor
final class MainTabsViewModel: ViewModelProtocol {
    var onNavigate: ((NavigationAction<NoRoute>) -> Void)?

    typealias Route = NoRoute

    @Published var selectedTab: AppTab = .home
    @Published var networkStatus: NetworkStatus = .connected

    private var cancellables = Set<AnyCancellable>()

    init(networkProvider: NetworkStatusProviding) {
        // bridge provider → @Published
        networkProvider.statusPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.networkStatus = $0 }
            .store(in: &cancellables)
    }

    func requiresNetwork(_ tab: AppTab) -> Bool {
        switch tab {
        case .home, .search: return true
        case .square, .library, .settings: return false
        }
    }
}
