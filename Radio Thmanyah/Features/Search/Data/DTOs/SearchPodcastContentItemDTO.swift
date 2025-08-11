//
//  PodcastContentItemDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


struct SearchPodcastContentItemDTO: Codable {
    let podcastID: String?
    let name: String?
    let description: String?
    let avatarURL: String?
    let episodeCount: String?
    let duration: String?
    let language: String?
    let priority: String?
    let popularityScore: String?
    let score: String?

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
