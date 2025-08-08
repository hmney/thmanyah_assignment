//
//  EpisodeCard.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct EpisodeCard: View {
    let title: String
    let podcast: String
    let imageURL: URL?
    let duration: Int
    
    var body: some View {
        HStack(spacing: 12) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    Rectangle().fill(AppColors.cardBackground).overlay(ProgressView())
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure:
                    Rectangle().fill(.gray.opacity(0.3))
                @unknown default:
                    Rectangle().fill(.gray.opacity(0.3))
                }
            }
            .frame(width: 84, height: 84)
            .cornerRadius(10)
            .clipped()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(title)
                    .ibmFont(.medium, size: 16)
                    .foregroundColor(AppColors.primaryText)
                    .multilineTextAlignment(.trailing)
                    .lineLimit(2)
                
                Text(podcast)
                    .ibmFont(.regular, size: 14)
                    .foregroundColor(AppColors.secondaryText)
                    .lineLimit(1)
                    .multilineTextAlignment(.trailing)
                
                Text(ArabicFormatters.duration(minutes: duration))
                    .ibmFont(.regular, size: 14)
                    .foregroundColor(AppColors.secondaryText)
                    .multilineTextAlignment(.trailing)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}
