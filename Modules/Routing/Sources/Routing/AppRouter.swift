//
//  AppRouter.swift
//  Routing
//
//  Created by fares on 18/06/2025.
//

import SwiftUI

public class AppRouter: Router {
    /// Published property that holds the ID of the movie selected for detail viewing.
    /// Setting this to a non-nil value will trigger a sheet presentation in `ContentView`.
    /// Setting it to `nil` will dismiss the sheet.
    @Published public var currentDestination: NavigationDestination? = nil

    /// The `NavigationPath` that drives hierarchical navigation in a `NavigationStack`.
    @Published public var navigationPath = NavigationPath()

    /// Initializes the `AppRouter`.
    public init() {}

    // MARK: - Router Protocol Conformance

    /// Pushes a new view onto the `NavigationStack` for the given destination.
    /// - Parameter destination: The `NavigationDestination` to push.
    public func push(destination: NavigationDestination) {
        navigationPath.append(destination)
    }

    /// Pops the top view from the `NavigationStack`.
    public func pop() {
        navigationPath.removeLast()
    }

    /// Pops all views from the `NavigationStack` back to the root.
    public func popToRoot() {
        navigationPath = NavigationPath()
    }
}
