//
//  Coordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//


import SwiftUI

@MainActor
protocol Coordinator: AnyObject {
    associatedtype Root: View
    func start() -> Root
}
