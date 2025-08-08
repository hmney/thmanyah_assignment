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

    var body: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            content
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(AppColors.primaryText)
                }
            }
        }
        .sheet(isPresented: $showSearch) {
            SearchContainer()
                .presentationDetents([.large])
        }
        .environment(\.layoutDirection, .rightToLeft)
        .onAppear { vm.onAppear() }
    }
    
    @ViewBuilder
    private var content: some View {
        switch vm.state.phase {
        case .idle, .loading:
            ProgressView().tint(AppColors.accentGold)
        case .empty:
            Text("لا يوجد محتوى متاح الآن.")
                .ibmFont(.medium, size: 16)
                .foregroundColor(AppColors.secondaryText)
        case .error(let msg):
            VStack(spacing: 12) {
                Text(msg)
                    .ibmFont(.medium, size: 16)
                    .foregroundColor(AppColors.secondaryText)
                Button("إعادة المحاولة") { vm.refresh() }
                    .buttonStyle(.bordered)
            }
        case .content:
            ScrollView {
                LazyVStack(spacing: 24) {
                    ForEach(vm.state.sections) { section in
                        SectionRenderer(section: section)
                    }
                    // TODO: we should handle pagination later
//                    if vm.state.nextPage != nil {
//                        HStack { Spacer(); ProgressView(); Spacer() }
//                            .padding(.vertical, 8)
//                            .onAppear {
//                                vm.loadNextPageIfNeeded()
//                            }
//                    }
                }
                .padding(.vertical, 16)
            }
        }
    }
}
