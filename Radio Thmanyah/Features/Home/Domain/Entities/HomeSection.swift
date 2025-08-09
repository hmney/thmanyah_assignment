//
//  HomeSection.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

struct HomeSection: Equatable, Identifiable {
    let id: UUID = UUID()
    let title: String
    let displayStyle: DisplayStyle
    let contentKind: ContentKind
    let order: Int
    let items: [ContentItem]
}
