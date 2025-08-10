//
//  SectionListScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


import SwiftUI

struct SectionListScreen: View {
    let title: String
    let items: [ContentItem]

    var body: some View {
        ScrollView {
            ForEach(items) { item in
                Text(item.id)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
