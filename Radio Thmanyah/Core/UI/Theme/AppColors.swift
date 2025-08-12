//
//  AppColors.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

enum AppColors {
    static let background = Color.black
    static let cardBackground = Color(hex: "#151515")
    static let primaryText = Color.white
    static let secondaryText = Color(hex: "#B6B6B6")
    static let accentGold = Color(hex: "#F7C23C")
    static let splashBackground = Color(hex: "#dc533e")
    static let textFieldBackground = Color(hex: "#1f1f1f")
}

// HEX to Color convenience
extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = Double((rgb & 0xFF0000) >> 16) / 255
        let g = Double((rgb & 0x00FF00) >> 8) / 255
        let b = Double(rgb & 0x0000FF) / 255
        
        self.init(red: r, green: g, blue: b)
    }
}
