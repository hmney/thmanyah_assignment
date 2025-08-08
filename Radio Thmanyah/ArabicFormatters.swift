//
//  ArabicFormatters.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

enum ArabicFormatters {
    static let arabicLocale = Locale(identifier: "ar")
    
    static func arabicIndicNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.locale = arabicLocale
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
    
    static func duration(minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        
        if hours > 0 {
            return "\(arabicIndicNumber(hours)) ساعة و\(arabicIndicNumber(mins)) دقيقة"
        } else {
            return "\(arabicIndicNumber(mins)) دقيقة"
        }
    }
}
