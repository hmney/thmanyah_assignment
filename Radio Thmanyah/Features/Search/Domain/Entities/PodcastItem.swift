//
//  PodcastItem.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


struct PodcastItem: Equatable, Identifiable {
    var id: String {
        if let pid = podcastId, !pid.isEmpty { return pid }
        return "\(name ?? "unknown")|\(avatarUrl ?? "na")|\(releaseDate ?? "na")"
    }

    let podcastId: String?
    let name: String?
    let description: String?
    let avatarUrl: String?
    let episodeCount: String?
    let duration: String?
    let language: String?
    let priority: String?
    let popularityScore: String?
    let score: String?
    let releaseDate: String?
}
