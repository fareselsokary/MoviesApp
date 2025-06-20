//
//  NetworkReachability.swift
//  Networking
//
//  Created by fares on 17/06/2025.
//

import Core
import Foundation
import Network

public final class NetworkReachability: ObservableObject {
    /// Shared singleton instance for easy access throughout the app.
    public static let shared = NetworkReachability()

    /// The network path monitor provided by the Network framework.
    private let monitor: NWPathMonitor
    /// A dedicated dispatch queue for the network monitor to avoid blocking the main thread.
    private let queue = DispatchQueue(label: "NetworkMonitor")

    /// A published property indicating the current network connection status.
    /// Defaults to `true` assuming a connection on startup until verified.
    @Published public private(set) var isConnected: Bool = true

    /// Initializes the network reachability monitor.
    private init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnected = true
                    Logger.verbose("Network status: Connected")
                } else {
                    self.isConnected = false
                    Logger.error("Network status: Disconnected")
                }
            }
        }
    }

    /// Starts monitoring the network status.
    public func start() {
        monitor.start(queue: queue)
    }

    /// Stops monitoring the network status.
    public func end() {
        monitor.cancel()
    }

    /// Cancels the network monitor when the object is deallocated.
    deinit {
        monitor.cancel()
    }
}
