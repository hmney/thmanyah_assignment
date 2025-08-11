//
//  ViewModelProtocol.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 11/8/2025.
//

import SwiftUI

@MainActor
protocol ViewModelProtocol: ObservableObject {
    associatedtype Route: BaseRoute
    var onNavigate: ((Route) -> Void)? { get set }
}
