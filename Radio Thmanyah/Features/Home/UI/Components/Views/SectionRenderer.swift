//
//  SectionRenderer.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import SwiftUI

struct SectionRenderer: View {
    let section: HomeSection
    @EnvironmentObject var homeViewModel: HomeViewModel

    var body: some View {
        VStack(alignment: .trailing, spacing: 12) {
            Button {
                homeViewModel.onNavigate?(.push(.section(section: section)))
            } label: {
                SectionHeader(title: section.title)
            }

            switch section.displayStyle {
            case .queue:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(section.items) { item in
                            card(
                                for: item,
                                action: {
                                    homeViewModel.onNavigate?(
                                        .push(.pageDetails(item: item))
                                    )
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            case .square, .bigSquare:
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(section.items) { item in
                            card(
                                for: item,
                                action: { homeViewModel.onNavigate?(.push(.pageDetails(item: item))) }
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                }
            case .twoLinesGrid:
                let rows = [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ]
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, spacing: 12) {
                        ForEach(section.items) { item in
                            card(
                                for: item,
                                action: { homeViewModel.onNavigate?(.push(.pageDetails(item: item))) }
                            )
                                .frame(maxHeight: .infinity, alignment: .top)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                }
            case .unknown:
                VStack(spacing: 12) {
                    ForEach(Array(section.items.enumerated()), id: \.offset) { _, item in
                        card(
                            for: item,
                            action: { homeViewModel.onNavigate?(.push(.pageDetails(item: item))) }
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
        }
    }

    @ViewBuilder
    func card(for item: ContentItem, action: @escaping () -> Void) -> some View {
        switch item {
        case .podcast(let id, let title, _, let avatarURL, let episodeCount, _, _):
            PodcastCard(
                title: title,
                imageURL: avatarURL,
                episodeCount: episodeCount ?? 0,
                action: action
            )
            .id(id)

        case .episode(
            let id,
            let title,
            let podcastName,
            _,
            _,
            let avatarURL,
            let duration,
            _
        ):
            EpisodeCard(
                title: title,
                podcast: podcastName ?? "",
                imageURL: avatarURL,
                duration: duration ?? 0,
                action: action
            )
            .id(id)

        case .audioBook(
            let id,
            let title,
            let authorName,
            _,
            let avatarURL,
            let duration,
            _
        ):
            AudiobookCard(
                title: title,
                author: authorName ?? "",
                imageURL: avatarURL,
                duration: duration ?? 0,
                action: action
            )
            .id(id)

        case .audioArticle(
            let id,
            let title,
            let authorName,
            _,
            let avatarURL,
            let duration,
            _
        ):
            ArticleCard(
                title: title,
                author: authorName ?? "",
                imageURL: avatarURL,
                duration: duration ?? 0,
                action: action
            )
            .id(id)
        }
    }
}
