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
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            
            HStack(spacing: 12) {
                RemoteImage(
                    url: imageURL,
                    size: .init(width: 84, height: 84),
                    cornerRadius: 10
                )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .ibmFont(.medium, size: 16)
                        .foregroundColor(AppColors.primaryText)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                    
                    Text(podcast)
                        .ibmFont(.regular, size: 14)
                        .foregroundColor(AppColors.secondaryText)
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 4) {
                        DurationChip(durationInSeconds: duration)
                        
                        Spacer()
                        
                        Image("more_horizontal")
                            .renderingMode(.template)
                            .foregroundStyle(.white)
                        
                        Image("add_to_queue")
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}
