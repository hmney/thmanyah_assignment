//
//  SplashScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var logoScale: CGFloat = 1.0
    @State private var logoOpacity: Double = 1.0

    var body: some View {
        ZStack {
            AppColors.splashBackground.ignoresSafeArea()

            Image("logo_splash")
                .resizable()
                .frame(width: 140, height: 140)
                .scaleEffect(logoScale)
                .opacity(logoOpacity)

            VStack {
                Spacer()

                Text("Made with hope by Houssam-Eddine Mney 🤍")
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                    .opacity(logoOpacity)
            }
        }
        .onDisappear {
            withAnimation(.easeIn(duration: 0.8)) {
                logoScale = 1.5
                logoOpacity = 0.0
            }
        }
    }
}
