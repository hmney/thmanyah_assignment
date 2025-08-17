//
//  BaseRoute.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation

protocol BaseRoute: Hashable, Identifiable {
    var id: String { get }
}

extension BaseRoute {
    var id: String { String(describing: self) }
}
