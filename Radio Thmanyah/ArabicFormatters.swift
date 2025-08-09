//
//  ArabicFormatters.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

enum Formatters {
    static func duration(seconds: Int) -> String {
        let hours = seconds / 3600
        let mins = (seconds % 3600) / 60

        if hours > 0 && mins > 0 {
            return "\(hours)h \(mins)m"
        } else if hours > 0 {
            return "\(hours)h"
        } else {
            return "\(mins)m"
        }
    }
}

