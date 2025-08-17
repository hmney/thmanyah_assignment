//
//  ViewModelProtocol.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

public enum NavigationAction<Route> {
    case push(Route)
    case sheet(Route)
    case fullScreen(Route)
    case pop
    case popToRoot
    case dismissSheet
    case dismissFull
}

@MainActor
protocol ViewModelProtocol: ObservableObject {
    associatedtype Route: BaseRoute
    var onNavigate: ((NavigationAction<Route>) -> Void)? { get set }

    func navigate(_ action: NavigationAction<Route>)
}

extension ViewModelProtocol {
    var onNavigate: ((NavigationAction<Route>) -> Void)? { nil }

    func navigate(_ action: NavigationAction<Route>) {
        onNavigate?(action)
    }
}
