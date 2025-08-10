//
//  HomeSectionDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

import Foundation

struct HomeSectionsResponseDTO: Codable {
    let sections: [SectionWrapperDTO]
    let pagination: PaginationDTO

    private enum CodingKeys: String, CodingKey {
        case sections
        case pagination
    }
}

struct SectionWrapperDTO: Codable {
    let name: String
    let type: String
    let contentType: String
    let order: Int
    let content: SectionContentDTO

    enum CodingKeys: String, CodingKey {
        case name, type
        case contentType = "content_type"
        case order, content
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        contentType = try container
            .decode(String.self, forKey: .contentType)

        order = try container.decode(Int.self, forKey: .order)

        switch contentType.lowercased() {
        case "podcast":
            let items = try container.decode([PodcastContentItemDTO].self, forKey: .content)
            content = .podcast(items)

        case "episode":
            let items = try container.decode([EpisodeContentItemDTO].self, forKey: .content)
            content = .episode(items)

        case "audio_book":
            let items = try container.decode([AudiobookContentItemDTO].self, forKey: .content)
            content = .audiobook(items)

        case "audio_article":
            let items = try container.decode([AudioArticleContentItemDTO].self, forKey: .content)
            content = .audioArticle(items)

        default:
            print("⚠️ Unknown content type: \(contentType)")
            content = .podcast([])
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(contentType, forKey: .contentType)
        try container.encode(order, forKey: .order)

        switch content {
        case .podcast(let items):
            try container.encode(items, forKey: .content)
        case .episode(let items):
            try container.encode(items, forKey: .content)
        case .audiobook(let items):
            try container.encode(items, forKey: .content)
        case .audioArticle(let items):
            try container.encode(items, forKey: .content)
        }
    }
}
