//
//  HomeScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var viewModel: HomeViewModel

    var body: some View {
        content
            .background(AppColors.background)
            .onAppear { viewModel.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state.phase {
        case .idle, .loading:
            VStack {
                LottieView(animationName: "Loader")
                    .frame(width: 60, height: 60)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        case .empty:
            Text("There's no content!")
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.secondaryText)
        case .error(let msg):
            VStack(spacing: 12) {
                Text(msg)
                    .ibmFont(.medium, size: 16)
                    .foregroundColor(AppColors.secondaryText)
                Button("Refresh") { viewModel.refresh() }
                    .buttonStyle(.bordered)
            }
        case .content:
            ScrollView {
                LazyVStack(spacing: 24) {
                    HomeHeaderView()
                    ContentTypeScrollBar(
                        selected: viewModel.selectedFilterBinding
                    )
                    if viewModel.displayedSections.isEmpty {
                        Text(
                            "No results for \(viewModel.state.selectedContentFilter.title)."
                        )
                        .ibmFont(.medium, size: 16)
                        .foregroundColor(AppColors.secondaryText)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 24)
                    } else {
                        ForEach(viewModel.displayedSections) { section in
                            SectionRenderer(
                                section: section,
                            )
                            .onAppear {
                                if section.id == viewModel.displayedSections.last?.id {
                                    viewModel.loadNextPageIfNeeded()
                                }
                            }
                        }

                        if viewModel.state.isPaginating || viewModel.canLoadMore {
                            HStack {
                                Spacer()
                                LottieView(animationName: "Loader")
                                    .frame(width: 60, height: 60)
                                Spacer()
                            }
                            .padding(.vertical, 12)
                        }

                    }
                }
            }
        }
    }
}
