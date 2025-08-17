//
//  SectionListScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


import SwiftUI

struct SectionListScreen: View {
    @Environment(\.dismiss) var dismiss

    let section: HomeSection

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(section.items.compactMap { $0 }) { contentItem in
                    ContentItemView(contentItem: contentItem)
                    Divider().background(Color.white.opacity(0.5))
                }
            }
        }
        .navigationBarBackButtonHidden()
        .toolbarBackground(.black, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image("navigation_arrow")
                        .renderingMode(.template)
                        .foregroundStyle(.white)
                }
            }

            ToolbarItem(placement: .topBarLeading) {
                Text(section.title)
                    .foregroundStyle(.white)
                    .ibmFont(.semiBold, size: 18)
            }
        }
        .frame(maxHeight: .infinity)
        .background(Color.black)
        .safeAreaPadding(.bottom, 40)
    }
}

private struct ContentItemView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel

    let contentItem: ContentItem

    var body: some View {
        Button {
            homeViewModel.onNavigate?(
                .push(.pageDetails(item: contentItem))
            )
        } label: {
            VStack(spacing: 5) {
                HStack(spacing: 12) {
                    RemoteImage(
                        url: contentItem.display.imageURL,
                        size: .init(width: 48, height: 48),
                        cornerRadius: 8
                    )

                    VStack(alignment: .leading, spacing: 4) {
                        Text(
                            Formatters
                                .shortDate(contentItem.display.releaseDate ?? .now)
                        )
                        .ibmFont(.medium, size: 12)
                        .foregroundColor(.gray)

                        Text(contentItem.display.title)
                            .ibmFont(.medium, size: 16)
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)

                        HStack {
                            Button(action: {}) {
                                Image("more_horizontal")
                                    .renderingMode(.template)
                                    .foregroundColor(.white)
                            }

                            Spacer()

                            if let duration = contentItem.display.durationSeconds {
                                DurationChip(durationInSeconds: duration)
                            }
                        }
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            }
        }
    }
}
