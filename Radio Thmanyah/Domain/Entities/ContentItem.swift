//
//  ContentItem.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

enum ContentItem: Equatable, Identifiable {
    var id: String {
        switch self {
        case .podcast(let id, _, _, _, _):      return "podcast:\(id)"
        case .episode(let id, _, _, _, _, _, _, _):   return "episode:\(id)"
        case .audioBook(let id, _, _, _, _, _):    return "audiobook:\(id)"
        case .audioArticle(let id, _, _, _, _, _): return "article:\(id)"
        }
    }
    var backendID: String {
        switch self {
        case .podcast(let id, _, _, _, _),
                .episode(let id, _, _, _, _, _, _, _),
                .audioBook(let id, _, _, _, _, _),
                .audioArticle(let id, _, _, _, _, _): return id
        }
    }

    case podcast(
        id: String,
        title: String,
        description: String?,
        avatarURL: URL?,
        episodeCount: Int?
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
        duration: Int?
    )

    case audioArticle(
        id: String,
        title: String,
        authorName: String?,
        description: String?,
        avatarURL: URL?,
        duration: Int?
    )
}
