//
//  ContentDetailScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


import SwiftUI
import Kingfisher

import SwiftUI
import Kingfisher

struct ContentDetailScreen: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.hasNotch) private var hasNotch

    let item: ContentItem
    private var data: ContentItem.DisplayData { item.display }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 16) {
                    RemoteImage(
                        url: data.imageURL,
                        size: .init(width: 200, height: 200),
                        cornerRadius: 20
                    )

                    Text(data.title)
                        .ibmFont(.medium, size: 20)
                        .foregroundStyle(.white)

                    if let subtitle = data.subtitle, !subtitle.isEmpty {
                        Text(subtitle)
                            .ibmFont(.medium, size: 16)
                            .foregroundStyle(.gray)
                    }

                    controls
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .safeAreaPadding(.top, hasNotch ? 84 : 40)
                .frame(maxWidth: .infinity)
                .background(
                    LinearGradient(
                        colors: [Color.brown.opacity(0.9), .black],
                        startPoint: .top, endPoint: .bottom
                    )
                    .ignoresSafeArea(edges: .top)
                )

                Divider()
                    .background(.white.opacity(0.3))
                    .frame(maxWidth: .infinity)

                if let html = data.description {
                    HTMLText(html, textColor: .white)
                        .padding()
                }
            }
            

        }
        .ignoresSafeArea()
        .background(.black)
        .navigationBarBackButtonHidden()
        .toolbarBackground(.hidden, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("navigation_arrow")
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                }
            }
        }
    }

    // MARK: - Subviews

    @ViewBuilder
    private var controls: some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Image(systemName: "ellipsis")
                    .foregroundColor(.white)
                    .font(.title2)
            }

            Button(action: {}) {
                Image(systemName: "gobackward.10")
                    .foregroundColor(.white)
                    .font(.title)
            }

            if let seconds = data.durationSeconds {
                HStack(spacing: 4) {
                    Image("play_icon")
                        .resizable()
                        .renderingMode(.template)
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.white)

                    Text(Formatters.duration(seconds: seconds))
                        .foregroundColor(.white)
                        .ibmFont(.medium, size: 18)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Capsule().fill(Color(hex: "#272938")))
            }

            Button(action: {}) {
                Image(systemName: "checkmark")
                    .foregroundColor(.white)
                    .font(.title2)
            }

            Button(action: {}) {
                Image(systemName: "list.bullet")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
    }
}

#Preview("Podcast") {
    ContentDetailScreen(item: .podcast(
        id: "p1",
        title: "Swift Over Coffee",
        description: "A podcast about Swift & iOS.",
        avatarURL: URL(string: "https://example.com/podcast.png"),
        episodeCount: 120,
        duration: 3000, releaseDate: .now
    ))
}

#Preview("Episode") {
    ContentDetailScreen(item: .episode(
        id: "e1",
        title: "Concurrency Deep Dive",
        podcastName: "Swift Over Coffee",
        authorName: "Paul & Sean",
        description: "We explore Swift concurrency in depth.",
        avatarURL: URL(string: "https://example.com/episode.png"),
        duration: 2200,
        releaseDate: Date()
    ))
}
