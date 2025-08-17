//
//  HomeRouter.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

@MainActor
final class HomeRouter: BaseRouter<HomeRoute> {
    typealias Route = HomeRoute

    func toSection(section: HomeSection) {
        push(.section(section: section))
    }

    func toDetail(item: ContentItem) {
        push(.pageDetails(item: item))
    }

    override func destination(for route: HomeRoute) -> AnyView {
        switch route {
        case .section(let data):
            return AnyView(SectionListScreen(section: data))
        case .pageDetails(let data):
            return AnyView(ContentDetailScreen(item: data))
        }
    }

    override func sheetView(for route: HomeRoute) -> AnyView {
        // add real sheets when you have them
        return AnyView(EmptyView())
    }

    override func fullScreenView(for route: HomeRoute) -> AnyView {
        // add real full-screen covers when you have them
        return AnyView(EmptyView())
    }
}
