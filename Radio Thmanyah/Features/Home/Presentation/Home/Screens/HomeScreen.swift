//
//  HomeScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject var vm: HomeViewModel
    @State private var showSearch = false
    @State private var selectedContentFilter: ContentFilter = .all

    var body: some View {
        content
            .background(AppColors.background)
            .onAppear { vm.onAppear() }
    }

    @ViewBuilder
    private var content: some View {
        switch vm.state.phase {
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
                Button("Refresh") { vm.refresh() }
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
                            SectionRenderer(section: section)
                                .onAppear {
                                    // when the last rendered section shows up, fetch next page
                                    if section.id == displayedSections.last?.id {
                                        vm.loadNextPageIfNeeded()
                                    }
                                }
                        }

                        // Paging footer
                        if vm.isPaginating || vm.canLoadMore {
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
        vm.state.sections.filter { $0.contentKind.matches(selectedContentFilter) }
    }
}
