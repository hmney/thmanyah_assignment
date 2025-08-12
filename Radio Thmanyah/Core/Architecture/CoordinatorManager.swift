//
//  CoordinatorManager.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 12/8/2025.
//


import Foundation

@MainActor
final class CoordinatorManager {
    private let factory: CoordinatorFactory
    private var activeCoordinators: [AppTab: AnyObject] = [:]
    
    init(factory: CoordinatorFactory) {
        self.factory = factory
    }
    
    func coordinator<T>(for tab: AppTab, type: T.Type) -> T? {
        if let existing = activeCoordinators[tab] as? T {
            return existing
        }
        
        let coordinator: AnyObject?
        switch tab {
        case .home:
            coordinator = factory.makeHomeCoordinator()
        case .search:
            coordinator = factory.makeSearchCoordinator()
        default:
            return nil
        }
        
        if let coordinator = coordinator {
            activeCoordinators[tab] = coordinator
        }
        
        return coordinator as? T
    }
    
    func releaseCoordinator(for tab: AppTab) {
        activeCoordinators.removeValue(forKey: tab)
    }
    
    func releaseAllCoordinators() {
        activeCoordinators.removeAll()
    }
}