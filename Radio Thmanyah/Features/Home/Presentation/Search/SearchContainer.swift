//
//  SearchContainer.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 8/8/2025.
//


import SwiftUI
import UIKit

struct SearchContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor(Color(AppColors.background))
        
        let label = UILabel()
        label.text = "شاشة البحث (UIKit) — قادمة قريبًا"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "IBMPlexSansArabic-Medium", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        vc.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
        ])
        return vc
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
