//
//  PodcastCard.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct PodcastCard: View {
    let title: String
    let imageURL: URL?
    let episodeCount: Int
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 8) {
            AsyncImage(url: imageURL) { phase in
                switch phase {
                case .empty:
                    Rectangle().fill(AppColors.cardBackground).overlay(ProgressView()).frame(width: 140, height: 140)
                case .success(let image):
                    image.resizable().scaledToFill().frame(width: 140, height: 140).clipped()
                case .failure:
                    Rectangle().fill(.gray.opacity(0.3)).frame(width: 140, height: 140)
                @unknown default:
                    Rectangle().fill(.gray.opacity(0.3)).frame(width: 140, height: 140)
                }
            }
            .cornerRadius(10)
            
            Text(title)
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)
                .frame(maxWidth: 140, alignment: .trailing)
            
            Text("\(ArabicFormatters.arabicIndicNumber(episodeCount)) حلقة")
                .ibmFont(.regular, size: 14)
                .foregroundColor(AppColors.secondaryText)
                .frame(maxWidth: 140, alignment: .trailing)
        }
    }
}
