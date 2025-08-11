//
//  LottieView.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import SwiftUI
import Lottie

// MARK: - LottieView - UIViewRepresentable wrapper
struct LottieView: UIViewRepresentable {
    let animationName: String
    let loopMode: LottieLoopMode
    let animationSpeed: CGFloat
    let contentMode: UIView.ContentMode
    @Binding var isAnimating: Bool
    
    init(
        animationName: String,
        loopMode: LottieLoopMode = .loop,
        animationSpeed: CGFloat = 1.0,
        contentMode: UIView.ContentMode = .scaleAspectFit,
        isAnimating: Binding<Bool> = .constant(true)
    ) {
        self.animationName = animationName
        self.loopMode = loopMode
        self.animationSpeed = animationSpeed
        self.contentMode = contentMode
        self._isAnimating = isAnimating
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView()
        
        // Load animation from bundle
        if let animation = LottieAnimation.named(animationName) {
            animationView.animation = animation
            animationView.loopMode = loopMode
            animationView.animationSpeed = animationSpeed
            animationView.contentMode = contentMode
            animationView.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(animationView)
            
            // Set up constraints
            NSLayoutConstraint.activate([
                animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
                animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let animationView = uiView.subviews.first as? LottieAnimationView else { return }
        
        if isAnimating {
            animationView.play()
        } else {
            animationView.pause()
        }
    }
}

// MARK: - Reusable Animation Components
struct LoadingView: View {
    var body: some View {
        VStack {
            LottieView(animationName: "Loader")
                .frame(width: 60, height: 60)
            
            Text("Loading...")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    LoadingView()
}
