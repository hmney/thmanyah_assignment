//
//  HeaderView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 9/8/2025.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack(spacing: 8) {
            Image("profile_picture")
                .resizable()
                .frame(width: 24, height: 24)

            Text("Welcome back, Houssam!")

            Image("thmanyah_subscription")
            Spacer()
            Image("no_notification")
                .resizable()
                .frame(width: 20, height: 20)
        }
        .padding(.horizontal)
    }
}

#Preview {
    HeaderView()
}
