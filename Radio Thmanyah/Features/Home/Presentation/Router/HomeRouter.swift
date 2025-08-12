//
//  HomeRouter.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

@MainActor
final class HomeRouter: BaseRouter<HomeRoute> {
    func toSection(section: HomeSection) {
        push(.section(section: section))
    }

    func toDetail(item: ContentItem) {
        push(.pageDetails(item: item))
    }
}
