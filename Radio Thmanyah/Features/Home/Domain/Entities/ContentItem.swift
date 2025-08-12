//
//  ContentItem.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

enum ContentItem: Equatable, Identifiable, Hashable {
    var id: String {
        switch self {
        case .podcast(let id, _, _, _, _, _, _):      return "podcast:\(id)"
        case .episode(let id, _, _, _, _, _, _, _):   return "episode:\(id)"
        case .audioBook(let id, _, _, _, _, _, _):    return "audiobook:\(id)"
        case .audioArticle(let id, _, _, _, _, _, _): return "article:\(id)"
        }
    }

    case podcast(
        id: String,
        title: String,
        description: String?,
        avatarURL: URL?,
        episodeCount: Int?,
        duration: Int?,
        releaseDate: Date?
    )

    case episode(
        id: String,
        title: String,
        podcastName: String?,
        authorName: String?,
        description: String?,
        avatarURL: URL?,
        duration: Int?,
        releaseDate: Date?
    )

    case audioBook(
        id: String,
        title: String,
        authorName: String?,
        description: String?,
        avatarURL: URL?,
        duration: Int?,
        releaseDate: Date?
    )

    case audioArticle(
        id: String,
        title: String,
        authorName: String?,
        description: String?,
        avatarURL: URL?,
        duration: Int?,
        releaseDate: Date?
    )
}

extension ContentItem {
    struct DisplayData: Equatable {
        let title: String
        let subtitle: String?
        let description: String?
        let imageURL: URL?
        let durationSeconds: Int?
        let releaseDate: Date?
    }

    var display: DisplayData {
        switch self {
        case let .podcast(_, title, description, avatarURL, episodeCount, duration, releaseDate):
            return .init(
                title: title,
                subtitle: episodeCount.map { "\($0) episodes" },
                description: description,
                imageURL: avatarURL,
                durationSeconds: duration,
                releaseDate: releaseDate
            )

        case let .episode(_, title, podcastName, authorName, description, avatarURL, duration, releaseDate):
            // Compose a nice subtitle like: "Podcast • Author • Jan 5, 2025"
            let parts: [String] = [
                podcastName,
                authorName,
                releaseDate.map { Formatters.shortDate($0) }
            ].compactMap { $0 }
            return .init(
                title: title,
                subtitle: parts.isEmpty ? nil : parts.joined(separator: " • "),
                description: description,
                imageURL: avatarURL,
                durationSeconds: duration,
                releaseDate: releaseDate
            )

        case let .audioBook(_, title, authorName, description, avatarURL, duration, releaseDate):
            return .init(
                title: title,
                subtitle: authorName,
                description: description,
                imageURL: avatarURL,
                durationSeconds: duration,
                releaseDate: releaseDate
            )

        case let .audioArticle(_, title, authorName, description, avatarURL, duration, releaseDate):
            return .init(
                title: title,
                subtitle: authorName,
                description: description,
                imageURL: avatarURL,
                durationSeconds: duration,
                releaseDate: releaseDate
            )
        }
    }
}
