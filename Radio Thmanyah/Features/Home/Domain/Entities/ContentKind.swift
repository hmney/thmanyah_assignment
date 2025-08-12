//
//  ContentKind.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

enum ContentKind: Equatable, Hashable {
    case podcast(String)
    case episode(String)
    case audioBook(String)
    case audioArticle(String)
    case unknown(String)

    /// Returns the API string for this kind (e.g., "podcast", "episode", "audio_book", "audio_article")
    var apiKey: String {
        switch self {
        case .podcast:       return "podcast"
        case .episode:       return "episode"
        case .audioBook:     return "audio_book"
        case .audioArticle:  return "audio_article"
        case .unknown(_):    return ""
        }
    }

    var filter: ContentFilter {
        switch self {
        case .podcast:       return .podcasts
        case .episode:       return .episodes
        case .audioBook:     return .audiobooks
        case .audioArticle:  return .audioArticles
        case .unknown(_):    return .all
        }
    }

    /// Convenience to check if this kind matches a UI filter.
    func matches(_ f: ContentFilter) -> Bool { f == .all || filter == f }
}
