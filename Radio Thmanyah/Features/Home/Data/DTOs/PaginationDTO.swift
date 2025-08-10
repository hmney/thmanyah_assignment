//
//  PaginationDTO.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//

struct PaginationDTO: Codable {
    let nextPage: String?
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case nextPage = "next_page"
        case totalPages = "total_pages"
    }
}
