//
//  ContentItem.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

enum ContentItem: Equatable {
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
