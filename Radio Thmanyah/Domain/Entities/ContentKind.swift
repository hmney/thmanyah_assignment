//
//  ContentKind.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

enum ContentKind: Equatable {
    case podcast(String)
    case episode(String)
    case audioBook(String)
    case audioArticle(String)
    case unknown(String)
    
    /// Returns the API string for this kind (e.g., "podcast", "episode", "audio_book", "audio_article")
    var apiKey: String {
        switch self {
        case .podcast(let s),
                .episode(let s),
                .audioBook(let s),
                .audioArticle(let s),
                .unknown(let s):
            return s
        }
    }
    
    /// Convenience to check if this kind matches a UI filter.
    func matches(_ filter: ContentFilter) -> Bool {
        switch filter {
        case .all:
            return true
        case .podcasts:
            return apiKey == "podcast"
        case .episodes:
            return apiKey == "episode"
        case .audiobooks:
            return apiKey == "audio_book"
        case .audioArticles:
            return apiKey == "audio_article"
        }
    }
}
