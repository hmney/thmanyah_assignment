//
//  CustomTabBar.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 40) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                TabButton(
                    image: tab.getIcon(isActiveState: selectedTab == tab),
                    isSelected: selectedTab == tab
                ) {
                    if selectedTab != tab {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        selectedTab = tab
                    }
                }
            }
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.black.opacity(0.75), .black]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

private struct TabButton: View {
    let image: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(image)
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
                .font(.system(size: 18, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 4)
                .contentShape(Rectangle())
                .accessibilityElement(children: .combine)
                .accessibilityLabel("")
                .accessibilityAddTraits(isSelected ? .isSelected : [])
        }
        .buttonStyle(.plain)
    }
}
