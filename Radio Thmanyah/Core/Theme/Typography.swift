//
//  Typography.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import SwiftUI

enum IBMPlexSansArabic {
    case thin, extraLight, light, regular, text, medium, semiBold, bold

    var name: String {
        switch self {
        case .thin:       return "IBMPlexSansArabic-Thin"
        case .extraLight: return "IBMPlexSansArabic-ExtraLight"
        case .light:      return "IBMPlexSansArabic-Light"
        case .regular:    return "IBMPlexSansArabic-Regular"
        case .text:       return "IBMPlexSansArabic-Text"
        case .medium:     return "IBMPlexSansArabic-Medium"
        case .semiBold:   return "IBMPlexSansArabic-SemiBold"
        case .bold:       return "IBMPlexSansArabic-Bold"
        }
    }
}

struct IBMPlexSansArabicModifier: ViewModifier {
    let weight: IBMPlexSansArabic
    let size: CGFloat
    let relativeTo: Font.TextStyle?

    func body(content: Content) -> some View {
        if let style = relativeTo {
            content.font(.custom(weight.name, size: size, relativeTo: style))
        } else {
            content.font(.custom(weight.name, size: size))
        }
    }
}

extension View {
    /// Use a fixed size
    func ibmFont(_ weight: IBMPlexSansArabic, size: CGFloat) -> some View {
        modifier(IBMPlexSansArabicModifier(weight: weight, size: size, relativeTo: nil))
    }

    /// Use Dynamic Type scaling
    func ibmFont(_ weight: IBMPlexSansArabic, size: CGFloat, relativeTo style: Font.TextStyle) -> some View {
        modifier(IBMPlexSansArabicModifier(weight: weight, size: size, relativeTo: style))
    }
}
