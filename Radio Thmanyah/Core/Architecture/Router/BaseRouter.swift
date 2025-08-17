//
//  BaseRouter.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

protocol BaseRouterProtocol: ObservableObject {}

@MainActor
class BaseRouter<Route: BaseRoute>: BaseRouterProtocol {

    // MARK: - Navigation state
    @Published var path: [Route] = []
    @Published var sheet: Route?
    @Published var fullScreenCover: Route?

    func destination(for route: Route) -> AnyView {
        AnyView(EmptyView())
    }

    func sheetView(for route: Route) -> AnyView {
        AnyView(EmptyView())
    }
    
    func fullScreenView(for route: Route) -> AnyView {
        AnyView(EmptyView())
    }

    // MARK: - Navigation API

    func push(_ route: Route) {
        path.append(route)
    }

    func pop() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func presentSheet(_ route: Route) {
        sheet = route
    }

    func dismissSheet() {
        sheet = nil
    }

    func presentFull(_ route: Route) {
        fullScreenCover = route
    }

    func dismissFull() {
        fullScreenCover = nil
    }
}
