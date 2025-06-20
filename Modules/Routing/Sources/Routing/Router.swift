//
//  Router.swift
//  Routing
//
//  Created by fares on 18/06/2025.
//

import SwiftUI

// MARK: - NavigationDestination

/// A comprehensive enum representing all possible navigation destinations in the application.
/// Conforms to `Identifiable` and `Hashable` to be used with SwiftUI's navigation modifiers.
public enum NavigationDestination: Identifiable, Hashable {
    case movieDetail(movieId: Int)

    public var id: String {
        switch self {
        case let .movieDetail(id): return "movieDetail-\(id)"
        }
    }
}

// MARK: - Router

/// Defines the navigation capabilities that can be injected into ViewModels.
/// This protocol decouples ViewModels from concrete navigation implementations.
public protocol Router: ObservableObject {
    /// The currently active modal navigation destination (e.g., for sheets or full-screen covers).
    /// Setting this property will trigger the presentation of the associated view.
    var currentDestination: NavigationDestination? { get set }

    /// A `NavigationPath` to support programmatic navigation within a `NavigationStack`.
    /// This property is managed by the router and updated when views are pushed/popped.
    var navigationPath: NavigationPath { get set }

    /// Pushes a new view onto the `NavigationStack` (if one is active) for the given destination.
    /// - Parameter destination: The `NavigationDestination` to push onto the stack.
    func push(destination: NavigationDestination)

    /// Pops the top view from the `NavigationStack`.
    func pop()

    /// Pops all views from the `NavigationStack` back to the root.
    func popToRoot()
}
