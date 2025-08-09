//
//  AudiobookCard.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct AudiobookCard: View {
    let title: String
    let author: String
    let imageURL: URL?
    let duration: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            RemoteImage(
                url: imageURL,
                size: .init(width: 180, height: 180),
                cornerRadius: 10
            )

            Text(title)
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.primaryText)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Text("\(author) • \(Formatters.duration(seconds: duration))")
                .ibmFont(.regular, size: 14)
                .foregroundColor(AppColors.secondaryText)
                .lineLimit(1)
                .multilineTextAlignment(.leading)
        }
    }
}
