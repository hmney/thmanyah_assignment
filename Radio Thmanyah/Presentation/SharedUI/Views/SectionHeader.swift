//
//  SectionHeader.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct SectionHeader: View {
    let title: String

    var body: some View {
        HStack {
            Text(title)
                .ibmFont(.bold, size: 20)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

            Image("arrow_left")
                .renderingMode(.template)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 16)
    }
}
