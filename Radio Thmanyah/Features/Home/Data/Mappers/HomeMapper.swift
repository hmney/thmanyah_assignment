//
//  HomeMapper.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

struct HomeMapper {
    static func mapHomeSections(sectionDTO: SectionWrapperDTO) -> HomeSection {
        return switch sectionDTO.content {
        case .podcast(let items):
             HomeMapper.mapPodcast(sectionDTO, items: items)
        case .episode(let items):
             HomeMapper.mapEpisode(sectionDTO, items: items)
        case .audiobook(let items):
             HomeMapper.mapAudiobook(sectionDTO, items: items)
        case .audioArticle(let items):
             HomeMapper.mapAudioArticle(sectionDTO, items: items)
        }

    }

    static func mapPagination(paginationDTO: PaginationDTO) -> Pagination {
        Pagination(
            nextPage: paginationDTO.nextPage, totalPages: paginationDTO.totalPages
        )
    }

    // MARK: - Private Helpers

    private static func mapPodcast(_ section: SectionWrapperDTO, items: [PodcastContentItemDTO]) -> HomeSection {
        HomeSection(
            title: section.name,
            displayStyle: NormalizeDisplayStyle.from(section.type),
            contentKind: .podcast(section.contentType),
            order: section.order,
            items: items.map {
                .podcast(
                    id: $0.podcastID,
                    title: $0.name,
                    description: $0.description,
                    avatarURL: URL(string: $0.avatarURL ?? ""),
                    episodeCount: $0.episodeCount,
                    duration: $0.duration,
                    releaseDate: Formatters.randomFormattedDate()
                )
            }
        )
    }

    private static func mapEpisode(_ section: SectionWrapperDTO, items: [EpisodeContentItemDTO]) -> HomeSection {
        HomeSection(
            title: section.name,
            displayStyle: NormalizeDisplayStyle.from(section.type),
            contentKind: .episode(section.contentType),
            order: section.order,
            items: items.map {
                .episode(
                    id: $0.episodeID,
                    title: $0.name,
                    podcastName: $0.podcastName,
                    authorName: $0.authorName,
                    description: $0.description,
                    avatarURL: URL(string: $0.avatarURL ?? ""),
                    duration: $0.duration,
                    releaseDate: $0.releaseDate
                )
            }
        )
    }

    private static func mapAudiobook(_ section: SectionWrapperDTO, items: [AudiobookContentItemDTO]) -> HomeSection {
        HomeSection(
            title: section.name,
            displayStyle: NormalizeDisplayStyle.from(section.type),
            contentKind: .audioBook(section.contentType),
            order: section.order,
            items: items.map {
                .audioBook(
                    id: UUID().uuidString,
                    title: $0.name,
                    authorName: $0.authorName,
                    description: $0.description,
                    avatarURL: URL(string: $0.avatarURL ?? ""),
                    duration: $0.duration,
                    releaseDate: Formatters.randomFormattedDate()
                )
            }
        )
    }

    private static func mapAudioArticle(_ section: SectionWrapperDTO, items: [AudioArticleContentItemDTO]) -> HomeSection {
        HomeSection(
            title: section.name,
            displayStyle: NormalizeDisplayStyle.from(section.type),
            contentKind: .audioArticle(section.contentType),
            order: section.order,
            items: items.map {
                .audioArticle(
                    id: UUID().uuidString,
                    title: $0.name,
                    authorName: $0.authorName,
                    description: $0.description,
                    avatarURL: URL(string: $0.avatarURL ?? ""),
                    duration: $0.duration,
                    releaseDate: Formatters.randomFormattedDate()
                )
            }
        )
    }
}
