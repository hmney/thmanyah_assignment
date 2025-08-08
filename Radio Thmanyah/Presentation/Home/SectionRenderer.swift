//
//  SectionRenderer.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct SectionRenderer: View {
    let section: HomeSection
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            SectionHeader(title: section.title)
            
            switch section.displayStyle {
            case .queue:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                            card(for: item)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            case .square, .bigSquare:
                let min: CGFloat = section.displayStyle == .bigSquare ? 160 : 130
                LazyVGrid(columns: [GridItem(.adaptive(minimum: min), spacing: 12)], spacing: 12) {
                    ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                        card(for: item)
                    }
                }
                .padding(.horizontal, 16)
            case .twoLinesGrid:
                VStack(spacing: 12) {
                    ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                        card(for: item)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .padding(.horizontal, 16)
            case .unknown:
                VStack(spacing: 12) {
                    ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                        card(for: item)
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }
    
    @ViewBuilder
    func card(for item: ContentItem) -> some View {
        switch item {

        case .podcast(let id, let title, let description, let avatarURL, let episodeCount):
            PodcastCard(
                title: title,
                imageURL: avatarURL,
                episodeCount: episodeCount ?? 0 // TODO: back to this later
            )
            .id(id)

        case .episode(let id, let title, let podcastName, let authorName, let description, let avatarURL, let duration, let releaseDate):
            EpisodeCard(
                title: title,
                podcast: podcastName ?? "", // TODO: back to this later
                imageURL: avatarURL,
                duration: duration ?? 0 // TODO: back to this later
            )
            .id(id)

        case .audioBook(let id, let title, let authorName, let description, let avatarURL, let duration):
            AudiobookCard(
                title: title,
                author: authorName ?? "", // TODO: back to this later
                imageURL: avatarURL,
                duration: duration ?? 0 // TODO: back to this later
            )
            .id(id)

        case .audioArticle(let id, let title, let authorName, let description, let avatarURL, let duration):
            ArticleCard(
                title: title,
                author: authorName ?? "", // TODO: back to this later
                imageURL: avatarURL,
                duration: duration ?? 0 // TODO: back to this later
            )
            .id(id)
        }
    }
}
