//
//  SplashScreen.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI

struct SplashScreen: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    
    var body: some View {
        ZStack {
            AppColors.splashBackground.ignoresSafeArea()

                Image("logo_splash")
                    .resizable()
                    .frame(width: 140, height: 140)
                    .scaleEffect(scale)
                    .opacity(opacity)

            VStack {
                Spacer()

                Text("Made with hope by Houssam-Eddine Mney 🤍")
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
            }
        }
        .onAppear {
            scale = 0.5
            opacity = 0
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = 1.0
                opacity = 1.0
            }
        }
    }
}
