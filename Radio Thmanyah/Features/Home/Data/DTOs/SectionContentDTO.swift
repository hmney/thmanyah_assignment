//
//  SectionContentDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

enum SectionContentDTO: Codable {
    case podcast([PodcastContentItemDTO])
    case episode([EpisodeContentItemDTO])
    case audiobook([AudiobookContentItemDTO])
    case audioArticle([AudioArticleContentItemDTO])
}
