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
        Text(title)
            .ibmFont(.bold, size: 20, relativeTo: .title3)
            .foregroundColor(AppColors.accentGold)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 16)
    }
}
