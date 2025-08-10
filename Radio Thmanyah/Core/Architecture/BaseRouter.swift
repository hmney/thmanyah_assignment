//
//  BaseRouter.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

@MainActor
class BaseRouter<R: BaseRoute>: ObservableObject {
    @Published var path = NavigationPath()
    @Published var sheet: R?
    @Published var fullScreenCover: R?

    func push(_ route: R)     { path.append(route) }
    func pop()                { path.removeLast() }
    func popToRoot()          { path.removeLast(path.count) }

    func presentSheet(_ r: R) { sheet = r }
    func dismissSheet()       { sheet = nil }

    func presentFull(_ r: R)  { fullScreenCover = r }
    func dismissFull()        { fullScreenCover = nil }
}
