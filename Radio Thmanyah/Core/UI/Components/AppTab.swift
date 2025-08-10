//
//  AppTab 2.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


enum AppTab: String, CaseIterable {
    case home
    case search
    case square
    case library
    case settings

    func getIcon(isActiveState: Bool) -> String {
        switch self {
        case .home:
            isActiveState ? "home_tab_active" : "home_tab_inactive"
        case .search: isActiveState ? "search_tab_active" : "search_tab_inactive"
        case .square:
            isActiveState ? "square_tab_active" : "square_tab_inactive"
        case .library: isActiveState ? "library_tab_active" : "library_tab_inactive"
        case .settings: isActiveState ? "settings_tab_active" : "settings_tab_inactive"
        }
    }
}
