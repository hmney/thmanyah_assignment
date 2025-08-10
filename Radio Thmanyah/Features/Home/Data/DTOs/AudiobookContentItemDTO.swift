//
//  AudiobookContentItemDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

struct AudiobookContentItemDTO: Codable {
    let audiobookID: String
    let name: String
    let authorName: String?
    let description: String?
    let avatarURL: String?
    let duration: Int?
    let language: String?
    let releaseDate: Date?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case audiobookID = "audiobook_id"
        case name
        case authorName = "author_name"
        case description
        case avatarURL = "avatar_url"
        case duration, language
        case releaseDate = "release_date"
        case score
    }
}
