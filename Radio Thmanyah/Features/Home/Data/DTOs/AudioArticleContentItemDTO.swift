//
//  AudioArticleContentItemDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import Foundation

struct AudioArticleContentItemDTO: Codable {
    let articleID: String
    let name: String
    let authorName: String?
    let description: String?
    let avatarURL: String?
    let duration: Int?
    let releaseDate: Date?
    let score: Double?
    
    enum CodingKeys: String, CodingKey {
        case articleID = "article_id"
        case name
        case authorName = "author_name"
        case description
        case avatarURL = "avatar_url"
        case duration
        case releaseDate = "release_date"
        case score
    }
}
