//
//  ContentDetailScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


import SwiftUI
import Kingfisher
//
//struct ContentDetailScreen: View {
//    let item: ContentItem
//
//    var body: some View {
//        ScrollView {
//            VStack(alignment: .leading, spacing: 16) {
//                headerArtwork
//                titleBlock
//                metaChips
//                actionButtons
//                descriptionBlock
//            }
//            .padding(.horizontal, 16)
//            .padding(.bottom, 24)
//        }
//        .background(AppColors.background.ignoresSafeArea())
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar { ToolbarItem(placement: .principal) { navTitle } }
//    }
//
//    // MARK: - Pieces
//
//    @ViewBuilder
//    private var headerArtwork: some View {
//        if let url = item.artworkURL {
//            KFImage(url)
//                .placeholder { Rectangle().fill(AppColors.cardBackground).overlay(ProgressView()) }
//                .cancelOnDisappear(true)
//                .downsampling(size: CGSize(width: 600, height: 600))
//                .resizable()
//                .scaledToFit()
//                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 16, style: .continuous)
//                        .stroke(.white.opacity(0.06), lineWidth: 1)
//                )
//                .shadow(radius: 6, y: 2)
//                .frame(maxWidth: .infinity)
//                .padding(.top, 16)
//        }
//    }
//
//    private var titleBlock: some View {
//        VStack(alignment: .leading, spacing: 6) {
//            Text(item.displayTitle)
//                .ibmFont(.medium, size: 20)
//                .foregroundColor(.white)
//                .fixedSize(horizontal: false, vertical: true)
//
//            if let subtitle = item.subtitleText {
//                Text(subtitle)
//                    .ibmFont(.regular, size: 14)
//                    .foregroundColor(AppColors.secondaryText)
//            }
//        }
//    }
//
//    @ViewBuilder
//    private var metaChips: some View {
//        HStack(spacing: 8) {
//            if let dur = item.durationSeconds {
//                DurationChip(seconds: dur) // you already have this
//            }
//            if let date = item.releaseDate {
//                Text(date.formatted(.dateTime.year().month().day()))
//                    .ibmFont(.medium, size: 12)
//                    .padding(.horizontal, 10).padding(.vertical, 6)
//                    .background(Capsule().fill(AppColors.cardBackground))
//                    .foregroundColor(.white)
//            }
//            Text(item.kindLabel)
//                .ibmFont(.medium, size: 12)
//                .padding(.horizontal, 10).padding(.vertical, 6)
//                .background(Capsule().fill(AppColors.cardBackground))
//                .foregroundColor(.white)
//        }
//    }
//
//    private var actionButtons: some View {
//        HStack(spacing: 12) {
//            Button {
//                // TODO: Play handler
//            } label: {
//                HStack(spacing: 8) {
//                    Image(systemName: "play.fill")
//                    Text("Play")
//                        .ibmFont(.medium, size: 16)
//                }
//                .frame(maxWidth: .infinity)
//                .padding(.vertical, 12)
//                .background(RoundedRectangle(cornerRadius: 12).fill(AppColors.accentRed))
//                .foregroundColor(.white)
//            }
//            .buttonStyle(.plain)
//
//            Button {
//                // TODO: Add to library
//            } label: {
//                Image(systemName: "plus")
//                    .frame(width: 44, height: 44)
//                    .background(RoundedRectangle(cornerRadius: 12).fill(AppColors.cardBackground))
//                    .foregroundColor(.white)
//            }
//            .buttonStyle(.plain)
//        }
//    }
//
//    @ViewBuilder
//    private var descriptionBlock: some View {
//        if let text = item.longDescription, !text.isEmpty {
//            VStack(alignment: .leading, spacing: 8) {
//                Text("Description")
//                    .ibmFont(.medium, size: 16)
//                    .foregroundColor(.white)
//                Text(text.strippingHTML())
//                    .ibmFont(.regular, size: 14)
//                    .foregroundColor(AppColors.secondaryText)
//            }
//        }
//    }
//
//    private var navTitle: some View {
//        Text(item.navTitle)
//            .ibmFont(.medium, size: 16)
//            .foregroundColor(.white)
//    }
//}
