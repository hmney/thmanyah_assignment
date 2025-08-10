//
//  EpisodeContentItemDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

struct EpisodeContentItemDTO: Codable {
    let podcastPopularityScore: Int?
    let podcastPriority: Int?
    let episodeID: String
    let name: String
    let seasonNumber: Int?
    let episodeType: String?
    let podcastName: String?
    let authorName: String?
    let description: String?
    let number: Int?
    let duration: Int?
    let avatarURL: String?
    let separatedAudioURL: String?
    let audioURL: String?
    let releaseDate: Date?
    let podcastID: String?
    let chapters: [Chapter]?
    let paidIsEarlyAccess: Bool?
    let paidIsNowEarlyAccess: Bool?
    let paidIsExclusive: Bool?
    let paidTranscriptURL: String?
    let freeTranscriptURL: String?
    let paidIsExclusivePartially: Bool?
    let paidExclusiveStartTime: Int?
    let paidEarlyAccessDate: String?
    let paidEarlyAccessAudioURL: String?
    let paidExclusivityType: String?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case podcastPopularityScore, podcastPriority
        case episodeID = "episode_id"
        case name
        case seasonNumber = "season_number"
        case episodeType = "episode_type"
        case podcastName = "podcast_name"
        case authorName = "author_name"
        case description, number, duration
        case avatarURL = "avatar_url"
        case separatedAudioURL = "separated_audio_url"
        case audioURL = "audio_url"
        case releaseDate = "release_date"
        case podcastID = "podcast_id"
        case chapters
        case paidIsEarlyAccess = "paid_is_early_access"
        case paidIsNowEarlyAccess = "paid_is_now_early_access"
        case paidIsExclusive = "paid_is_exclusive"
        case paidTranscriptURL = "paid_transcript_url"
        case freeTranscriptURL = "free_transcript_url"
        case paidIsExclusivePartially = "paid_is_exclusive_partially"
        case paidExclusiveStartTime = "paid_exclusive_start_time"
        case paidEarlyAccessDate = "paid_early_access_date"
        case paidEarlyAccessAudioURL = "paid_early_access_audio_url"
        case paidExclusivityType = "paid_exclusivity_type"
        case score
    }
}

struct Chapter: Codable {}
