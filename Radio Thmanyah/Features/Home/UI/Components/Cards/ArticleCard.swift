//
//  ArticleCard.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct ArticleCard: View {
    let title: String
    let author: String
    let imageURL: URL?
    let duration: Int
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                RemoteImage(
                    url: imageURL,
                    size: .init(width: 160, height: 160),
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
}
