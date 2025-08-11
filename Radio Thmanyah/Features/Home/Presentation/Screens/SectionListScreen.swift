//
//  SectionListScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


import SwiftUI

struct SectionListScreen: View {
    let section: HomeSection

    var body: some View {
        ScrollView {
            ForEach(section.items) { item in
                Text(item.id)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .background(AppColors.background)
    }
}
