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

    static func shortDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .medium
        f.timeStyle = .none

        // Format as dd MMM yyyy
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMM yyyy"
        return f.string(from: date)
    }

    static func randomFormattedDate() -> Date {
        let calendar = Calendar.current

        // Pick a random date within a range
        let startDate = calendar.date(from: DateComponents(year: 2020, month: 1, day: 1))!
        let endDate = Date()

        let timeInterval = endDate.timeIntervalSince(startDate)
        let randomInterval = TimeInterval.random(in: 0..<timeInterval)
        let randomDate = startDate.addingTimeInterval(randomInterval)

        return randomDate
    }
}

