//
//  DIContainer.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 10/8/2025.
//

import Foundation

@MainActor
public final class DIContainer {
    public typealias Factory = (DIContainer) -> Any

    private var factories: [ObjectIdentifier: Factory] = [:]
    private var singletons: [ObjectIdentifier: Any] = [:]
    private var singletonKeys: Set<ObjectIdentifier> = []

    public init() {}

    public func register<S>(_ type: S.Type, scopeSingleton: Bool = true, factory: @escaping (DIContainer) -> S) {
        let key = ObjectIdentifier(type)
        factories[key] = { c in factory(c) }
        if scopeSingleton {
            singletonKeys.insert(key)
        } else {
            singletonKeys.remove(key)
            singletons.removeValue(forKey: key)
        }
    }

    public func resolve<S>(_ type: S.Type = S.self) -> S {
        let key = ObjectIdentifier(type)

        if let instance = singletons[key] as? S { return instance }

        guard let factory = factories[key] else {
            fatalError("No factory for \(type)")
        }
        let instance = factory(self) as! S
        if singletonKeys.contains(key) {
            singletons[key] = instance
        }
        return instance
    }

    // Feature-scoped child container (override/extend registrations)
    public func child(_ configure: (DIContainer) -> Void) -> DIContainer {
        let child = DIContainer()
        child.factories = factories
        child.singletons = singletons
        child.singletonKeys = singletonKeys               
        configure(child)
        return child
    }
}
