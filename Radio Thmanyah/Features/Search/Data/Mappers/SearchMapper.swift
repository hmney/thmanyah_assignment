//
//  HomeMapper.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation


struct SearchMapper {
    static func mapSearchResponse(_ responseDTO: SearchResponseDTO) -> SearchResponse {
        .init(
            sections: responseDTO.sections.map(mapSearchSection)
        )
    }

    private static func mapSearchSection(sectionDTO: SearchSectionDTO) -> SearchSection {
        SearchSection(
            name: sectionDTO.name,
            type: sectionDTO.type,
            contentType: sectionDTO.contentType,
            order: sectionDTO.order,
            content: sectionDTO.content.map {
                PodcastItem(
                    podcastId: $0.podcastID,
                    name: $0.name,
                    description: $0.description,
                    avatarUrl: $0.avatarURL,
                    episodeCount: $0.episodeCount,
                    duration: $0.duration,
                    language: $0.language,
                    priority: $0.priority,
                    popularityScore: $0.popularityScore,
                    score: $0.score,
                    releaseDate: Formatters
                        .shortDate(Formatters
                        .randomFormattedDate())
                )
            }
        )
    }
}
