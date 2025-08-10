//
//  HomeScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct HomeScreen: View {
    @ObservedObject var viewModel: HomeViewModel

    @State private var showSearch = false
    @State private var selectedContentFilter: ContentFilter = .all

    var body: some View {
        content
            .background(AppColors.background)
            .onAppear { viewModel.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        switch viewModel.state.phase {
        case .idle, .loading:
            ProgressView().tint(AppColors.accentGold)
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
                    HeaderView()
                    ContentTypeScrollBar(selected: $selectedContentFilter)
                    if displayedSections.isEmpty {
                        Text("No results for \(selectedContentFilter.title).")
                            .ibmFont(.medium, size: 16)
                            .foregroundColor(AppColors.secondaryText)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 24)
                    } else {
                        ForEach(displayedSections) { section in
                            SectionRenderer(section: section, action: {
                                viewModel.onNavigate?(.section(section: section))
                            })
                                .onAppear {
                                    if section.id == displayedSections.last?.id {
                                        viewModel.loadNextPageIfNeeded()
                                    }
                                }
                        }
                        
                        if viewModel.isPaginating || viewModel.canLoadMore {
                            HStack {
                                Spacer()
                                ProgressView().tint(AppColors.accentGold)
                                Spacer()
                            }
                            .padding(.vertical, 12)
                        }

                    }
                }
            }
        }
    }

    private var displayedSections: [HomeSection] {
        viewModel.state.sections.filter { $0.contentKind.matches(selectedContentFilter) }
    }
}
