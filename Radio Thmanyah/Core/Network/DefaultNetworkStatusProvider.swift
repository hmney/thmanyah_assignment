//
//  DefaultNetworkStatusProvider.swift
//  Radio Thmanyah
//
//  Created by Houssam-Eddine Mney on 16/8/2025.
//

import Foundation
import Network
import Combine

public enum NetworkStatus { case connected, disconnected }

public protocol NetworkStatusProviding: AnyObject {
    var status: NetworkStatus { get }
    var statusPublisher: AnyPublisher<NetworkStatus, Never> { get }
}

final class DefaultNetworkStatusProvider: NetworkStatusProviding {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "net.status.monitor")
    private let subject: CurrentValueSubject<NetworkStatus, Never>
    var status: NetworkStatus { subject.value }
    var statusPublisher: AnyPublisher<NetworkStatus, Never> { subject.eraseToAnyPublisher() }

    init() {
        subject = .init(.connected)
        monitor.pathUpdateHandler = { [weak subject] path in
            subject?.send(path.status == .satisfied ? .connected : .disconnected)
        }
        monitor.start(queue: queue)
    }

    deinit { monitor.cancel() }
}
