//
//  ThemePreview.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct ThemePreview: View {
    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .trailing, spacing: AppSpacing.l) {
                    
                    sectionHeader("البودكاست المقترحة")
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: AppSpacing.m) {
                            ForEach(0..<4) { _ in
                                podcastCard(
                                    title: "فنجان",
                                    subtitle: "حوار عميق حول الثقافة والهوية والعمل.",
                                    episodeCount: 25
                                )
                            }
                        }
                        .padding(.horizontal, AppSpacing.m)
                    }
                    
                    sectionHeader("حلقات جديدة")
                    
                    VStack(spacing: AppSpacing.m) {
                        ForEach(0..<3) { _ in
                            episodeCard(
                                title: "هل يمكن للذكاء الاصطناعي أن يبدع فعلًا؟",
                                podcast: "فنجان",
                                duration: 32
                            )
                        }
                    }
                    .padding(.horizontal, AppSpacing.m)
                }
                .padding(.top, AppSpacing.l)
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
    }
    
    private func sectionHeader(_ text: String) -> some View {
        Text(text)
            .ibmFont(.bold, size: 20)
            .foregroundColor(AppColors.accentGold)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, AppSpacing.m)
    }
    
    private func podcastCard(title: String, subtitle: String, episodeCount: Int) -> some View {
        VStack(alignment: .trailing, spacing: AppSpacing.s) {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 140, height: 140)
                .cornerRadius(8)
            
            Text(title)
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)
            
            Text("\(ArabicFormatters.arabicIndicNumber(episodeCount)) حلقة")
                .ibmFont(.regular, size: 14)
                .foregroundColor(AppColors.secondaryText)
        }
    }
    
    private func episodeCard(title: String, podcast: String, duration: Int) -> some View {
        HStack(spacing: AppSpacing.m) {
            Rectangle()
                .fill(Color.gray)
                .frame(width: 80, height: 80)
                .cornerRadius(8)
            
            VStack(alignment: .trailing, spacing: AppSpacing.xs) {
                Text(title)
                    .ibmFont(.medium, size: 16)
                    .foregroundColor(AppColors.primaryText)
                    .lineLimit(2)
                
                Text(podcast)
                    .ibmFont(.regular, size: 14)
                    .foregroundColor(AppColors.secondaryText)
                
                Text(ArabicFormatters.duration(minutes: duration))
                    .ibmFont(.regular, size: 14)
                    .foregroundColor(AppColors.secondaryText)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    ThemePreview()
}
