//
//  FinishableCoordinator.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//

import Foundation

public enum CoordinatorResult {
    case completed(Any?)
    case cancelled
    case failed(Error)
}

public protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: AnyObject, result: CoordinatorResult)
}

@MainActor
public protocol FinishableCoordinator: AnyObject {
    var onFinish: ((CoordinatorResult) -> Void)? { get set }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    func finish(_ result: CoordinatorResult)
}

public extension FinishableCoordinator {
    func finish(_ result: CoordinatorResult) {
        onFinish?(result)
        finishDelegate?.coordinatorDidFinish(self, result: result)
    }
}
