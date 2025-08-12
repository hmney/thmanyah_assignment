//
//  Untitled.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import UIKit

extension UIFont.Weight {
    var fontSuffix: String {
        switch self {
        case .ultraLight: return "Thin"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "SemiBold"
        case .bold: return "Bold"
        case .heavy: return "Bold"
        case .black: return "Bold"
        default: return "Regular"
        }
    }
}
