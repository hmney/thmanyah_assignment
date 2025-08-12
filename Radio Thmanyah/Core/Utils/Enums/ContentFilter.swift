//
//  ContentFilter.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//


public enum ContentFilter: String, CaseIterable, Identifiable {
    case all
    case podcasts
    case episodes
    case audiobooks
    case audioArticles

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .all:            return "All"
        case .podcasts:       return "Podcasts"
        case .episodes:       return "Episodes"
        case .audiobooks:     return "Audiobooks"
        case .audioArticles:  return "Audio Articles"
        }
    }

    public var apiContentType: String? {
        switch self {
        case .all:            return nil
        case .podcasts:       return "podcast"
        case .episodes:       return "episode"
        case .audiobooks:     return "audio_book"
        case .audioArticles:  return "audio_article"
        }
    }
}