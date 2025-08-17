//
//  SearchScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

struct SearchScreen: View {
    @EnvironmentObject var viewModel: SearchViewModel
    @FocusState private var isSearchFieldFocused: Bool

    var body: some View {
        VStack(spacing: 0) {
            header
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(AppColors.background)
        .task { try? await viewModel.loadIntialData() }
        .alert("Error", isPresented: errorIsPresentedBinding, actions: {
            Button("OK") { viewModel.dismissError() }
        }, message: {
            if case .error(let message) = viewModel.state.phase {
                Text(message)
            }
        })
    }

    // MARK: - Header (Search field + Cancel)
    private var header: some View {
        HStack(spacing: 8) {
            searchInputField

            if isSearchFieldFocused {
                Button("Cancel") {
                    viewModel.clearSearch()
                    isSearchFieldFocused = false
                }
                .foregroundStyle(.white)
                .transition(.opacity.combined(with: .move(edge: .trailing)))
            } else {
                Image("add_search")
                    .padding(.horizontal, 4)
            }
        }
        .padding()
        .animation(.easeInOut(duration: 0.2), value: isSearchFieldFocused)
    }

    private var searchInputField: some View {
        HStack(spacing: 8) {
            Image("search_icon")
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundStyle(.white)

            TextField(text: Binding(
                get: { viewModel.state.query },
                set: { viewModel.setQuery($0) })
            ) {
                Text("Find a show, a book, a person...")
                    .foregroundStyle(Color(hex: "#5C5C5E"))
                    .ibmFont(.semiBold, size: 16)
            }
            .foregroundStyle(.white)
            .focused($isSearchFieldFocused)
            .textInputAutocapitalization(.none)
            .disableAutocorrection(true)
            .textFieldStyle(.plain)
            .submitLabel(.search)

            if !viewModel.state.query.isEmpty {
                Button {
                    viewModel.clearSearch()
                } label: {
                    Image("close_circle")
                        .foregroundStyle(.secondary)
                }
                .accessibilityLabel("Clear search")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 40)
        .background(AppColors.textFieldBackground)
        .cornerRadius(100)
    }

    // MARK: - Content
    @ViewBuilder
    private var content: some View {
        switch viewModel.state.phase {
        case .idle, .loadingInitial:
            loadingView
        case .showingInitial:
            if let data = viewModel.state.initialSections {
                initialSectionsResultsView(data)
            } else {
                emptyStateView
            }
        case .searching:
            loadingView
        case .results:
            if let results = viewModel.state.results {
                searchResultsView(results)
            } else {
                emptyStateView
            }
        case .empty:
            emptyStateView
        case .error:
            if let results = viewModel.state.results {
                searchResultsView(results)
            } else if let data = viewModel.state.initialSections {
                initialSectionsResultsView(data)
            } else {
                emptyStateView
            }
        }
    }

    // MARK: - Loading
    private var loadingView: some View {
        VStack(spacing: 16) {
            LottieView(animationName: "Loader")
                .frame(width: 60, height: 60)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 60)
    }

    // MARK: - Results
    private func searchResultsView(_ results: SearchResponse) -> some View {
        // Use LazyVStack for performance on long lists
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                ForEach(results.sections.flatMap { $0.content }) { podcast in
                    PodcastRowView(podcast: podcast)
                    Divider().background(Color.white.opacity(0.5))
                }
            }
            .background(Color.black)
        }
    }

    // MARK: - Initial Sections (Trending)
    private func initialSectionsResultsView(_ results: SearchResponse) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Trending Shows")
                .ibmFont(.bold, size: 26)
                .foregroundStyle(.white)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(results.sections.flatMap { $0.content }) { podcast in
                        PodcastCard(
                            title: podcast.name ?? "",
                            imageURL: URL(string: podcast.avatarUrl ?? ""),
                            episodeCount: Int(podcast.episodeCount ?? "0") ?? 0,
                            action: {}
                        )
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
    }

    // MARK: - Empty
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))

            Text("Start searching")
                .font(.system(size: 18, weight: .medium))

            Text("Find your favorite shows, books, and more")
                .font(.system(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 60)
    }

    // MARK: - Helpers
    private var errorIsPresentedBinding: Binding<Bool> {
        Binding(
            get: {
                if case .error = viewModel.state.phase { return true }
                return false
            },
            set: { presented in
                if !presented { viewModel.dismissError() }
            }
        )
    }
}

// MARK: - Row (split out to keep the screen lean)
private struct PodcastRowView: View {
    let podcast: PodcastItem

    var body: some View {
        VStack(spacing: 5) {
            HStack(spacing: 12) {
                RemoteImage(
                    url: URL(string: podcast.avatarUrl ?? ""),
                    size: .init(width: 48, height: 48),
                    cornerRadius: 8
                )

                VStack(alignment: .leading, spacing: 4) {
                    Text(podcast.releaseDate ?? "")
                        .ibmFont(.medium, size: 12)
                        .foregroundColor(.gray)

                    Text(podcast.name ?? "")
                        .ibmFont(.medium, size: 16)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)

                    HStack {
                        Button(action: {
                            // TODO: viewModel.onNavigate?(.podcastMoreOptions(id: ...))
                        }) {
                            Image("more_horizontal")
                                .renderingMode(.template)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        if let durationString = podcast.duration, let duration = Int(durationString) {
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
