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
        VStack(alignment: .trailing, spacing: 8) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty: Rectangle().fill(AppColors.cardBackground).overlay(ProgressView())
                case .success(let image): image.resizable().scaledToFill()
                case .failure: Rectangle().fill(.gray.opacity(0.3))
                @unknown default: Rectangle().fill(.gray.opacity(0.3))
                }
            }
            .frame(height: 180)
            .cornerRadius(10)
            .clipped()
            
            Text(title)
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.primaryText)
                .lineLimit(2)
                .multilineTextAlignment(.trailing)
            
            Text("\(author) • \(ArabicFormatters.duration(minutes: duration))")
                .ibmFont(.regular, size: 14)
                .foregroundColor(AppColors.secondaryText)
                .lineLimit(1)
                .multilineTextAlignment(.trailing)
        }
    }
}
