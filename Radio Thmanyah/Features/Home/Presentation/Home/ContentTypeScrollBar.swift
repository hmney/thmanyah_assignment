//
//  ContentTypeScrollBar.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import SwiftUI

public enum ContentFilter: String, CaseIterable, Identifiable {
    case all
    case podcasts
    case episodes
    case audiobooks
    case audioArticles

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .all:            return "All"
        case .podcasts:       return "Podcasts"
        case .episodes:       return "Episodes"
        case .audiobooks:     return "Audiobooks"
        case .audioArticles:  return "Audio Articles"
        }
    }

    public var apiContentType: String? {
        switch self {
        case .all:            return nil
        case .podcasts:       return "podcast"
        case .episodes:       return "episode"
        case .audiobooks:     return "audio_book"
        case .audioArticles:  return "audio_article"
        }
    }
}

public struct ContentTypeScrollBar: View {
    @Binding var selected: ContentFilter

    public init(selected: Binding<ContentFilter>) {
        self._selected = selected
    }

    public var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(ContentFilter.allCases) { option in
                    OptionChip(
                        title: option.title,
                        isSelected: selected == option
                    ) {
                        withAnimation(.easeInOut) {
                            selected = option
                        }
                    }
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(Text(option.title))
                    .accessibilityAddTraits(selected == option ? .isSelected : [])
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
        }
    }
}

private struct OptionChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .ibmFont(.medium, size: 14)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color(hex: "#dc533e") : Color(hex: "#14151e"))
                )
                .foregroundColor(.white)
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Preview

private struct ContentTypeScrollBarPreview: View {
    @State private var selected: ContentFilter = .all

    var body: some View {
        VStack(spacing: 16) {
            ContentTypeScrollBar(selected: $selected)

            Text("Selected: \(selected.title)")
                .ibmFont(.medium, size: 16)
                .padding()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentTypeScrollBarPreview()
}
