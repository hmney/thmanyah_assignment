//
//  SearchSectionDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation

struct SearchSectionDTO: Codable {
    let name: String
    let type: String
    let contentType: String
    let order: String
    let content: [SearchPodcastContentItemDTO]

    enum CodingKeys: String, CodingKey {
        case name, type, order, content
        case contentType = "content_type"
    }
}
