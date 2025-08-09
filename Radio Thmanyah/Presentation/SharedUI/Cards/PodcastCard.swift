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
        VStack(alignment: .leading, spacing: 8) {
            RemoteImage(
                url: imageURL,
                size: .init(width: 140, height: 140),
                cornerRadius: 10
            )

            Text(title)
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.primaryText)
                .lineLimit(1)
                .frame(maxWidth: 140, alignment: .leading)

            Text("\(episodeCount) episodes")
                .ibmFont(.regular, size: 14)
                .foregroundColor(AppColors.secondaryText)
                .frame(maxWidth: 140, alignment: .leading)
        }
    }
}
