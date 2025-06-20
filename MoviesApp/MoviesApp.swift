//
//  MoviesAppApp.swift
//  MoviesApp
//
//  Created by fares on 17/06/2025.
//

import Core
import Kingfisher
import Networking
import Routing
import SwiftUI

// MARK: - MoviesApp

@main
struct MoviesApp: App {
    @StateObject private var appRouter: AppRouter = AppRouter()

    init() {
        setupDebugger()
        startNetworkListener()
        setupDefaultNetworkConfiguration()
        configureImageCache()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appRouter)
        }
    }
}

extension MoviesApp {
    private func setupDefaultNetworkConfiguration() {
        let networkConfiguration = NetworkConfiguration.shared
        networkConfiguration.baseURL = Constants.baseURL
        networkConfiguration.apiKey = Constants.apiKey
        networkConfiguration.defaultHeaders = [
            "Authorization": "Bearer \(Constants.apiKey)",
            "accept": "application/json"
        ]
    }
}

extension MoviesApp {
    private func setupDebugger() {
        #if !DEBUG
            Logger.isLoggingEnabled = false
        #endif
    }
}

extension MoviesApp {
    private func startNetworkListener() {
        NetworkReachability.shared.start()
    }
}

extension MoviesApp {
    private func configureImageCache() {
        // Limit disk cache size to 500 MB
        KingfisherManager.shared.cache.diskStorage.config.sizeLimit = 500 * 1024 * 1024
        // Limit memory cache size to 150 MB
        KingfisherManager.shared.cache.memoryStorage.config.totalCostLimit = 150 * 1024 * 1024
        // Limit memory cache to hold up to 50 images
        KingfisherManager.shared.cache.memoryStorage.config.countLimit = 50
        // Memory images expire after 10 minutes
        KingfisherManager.shared.cache.memoryStorage.config.expiration = .seconds(10 * 60)
        // Disk cache expires after 7 days
        KingfisherManager.shared.cache.diskStorage.config.expiration = .days(7)
    }
}
