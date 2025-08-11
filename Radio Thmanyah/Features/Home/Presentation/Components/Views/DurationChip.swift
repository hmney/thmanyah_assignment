//
//  DurationChip.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import SwiftUI

struct DurationChip: View {
    let durationInSeconds: Int

    var body: some View {
        HStack(spacing: 4) {
            Image("play_icon")
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(.white)

            Text(Formatters.duration(seconds: durationInSeconds))
                .foregroundColor(.white)
                .ibmFont(.medium, size: 12)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color(hex: "#272938"))
        )
    }
}

#Preview {
    VStack(spacing: 20) {
        DurationChip(durationInSeconds: 1800) // 30 min
        DurationChip(durationInSeconds: 5400) // 1h 30 min
    }
    .padding()
    .background(Color.black)
}
