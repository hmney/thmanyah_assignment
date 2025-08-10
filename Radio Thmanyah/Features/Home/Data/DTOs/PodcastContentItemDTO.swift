//
//  PodcastContentItemDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

struct PodcastContentItemDTO: Codable {
    let podcastID: String
    let name: String
    let description: String?
    let avatarURL: String?
    let episodeCount: Int?
    let duration: Int?
    let language: String?
    let priority: Int?
    let popularityScore: Int?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case podcastID = "podcast_id"
        case name, description
        case avatarURL = "avatar_url"
        case episodeCount = "episode_count"
        case duration, language, priority
        case popularityScore
        case score
    }
}
