//
//  RemoteImage.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//


import SwiftUI
import Kingfisher
import Shimmer

struct RemoteImage: View {
    let url: URL?
    var size: CGSize
    var cornerRadius: CGFloat = 10

    private var scale: CGFloat { UIScreen.main.scale }
    private var pixelSize: CGSize {
        .init(width: size.width * scale, height: size.height * scale)
    }

    var body: some View {
        KFImage(url)
            .placeholder {
                placeholder
            }
            .onFailure { error in
                print("KF decode failed:", url?.absoluteString ?? "nil", error)
            }
            .scaleFactor(scale)
            .setProcessor(
                ResizingImageProcessor(referenceSize: pixelSize, mode: .aspectFill)
                |> RoundCornerImageProcessor(cornerRadius: cornerRadius * scale, backgroundColor: .clear)
            )
            .cacheOriginalImage()
            .fade(duration: 0.2)
            .backgroundDecode()
            .cancelOnDisappear(true)
            .resizable()
            .scaledToFill()
            .frame(width: size.width, height: size.height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .contentShape(.rect(cornerRadius: cornerRadius, style: .continuous))
            .clipped(antialiased: true)
    }
    
    @ViewBuilder
    private var placeholder: some View {
        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            .fill(Color(.secondarySystemBackground))
            .frame(width: size.width, height: size.height)
            .shimmering()
    }
}

// simple pipe helper to chain processors
infix operator |> : AdditionPrecedence
func |> (lhs: ImageProcessor, rhs: ImageProcessor) -> ImageProcessor {
    return lhs.append(another: rhs)
}
