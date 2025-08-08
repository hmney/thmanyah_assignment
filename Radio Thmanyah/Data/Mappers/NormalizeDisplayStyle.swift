//
//  NormalizeDisplayStyle.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

struct NormalizeDisplayStyle {
    static func from(_ raw: String) -> DisplayStyle {
        let normalized = raw.lowercased().replacingOccurrences(of: " ", with: "_")
        switch normalized {
        case "queue": return .queue
        case "square": return .square
        case "big_square": return .bigSquare
        case "2_lines_grid": return .twoLinesGrid
        default: return .unknown(raw)
        }
    }
}
