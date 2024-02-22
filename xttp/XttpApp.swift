//
//  xttpApp.swift
//  xttp
//
//  Created by Wender on 11/02/24.
//

import SwiftUI
import SwiftData

@main
struct XttpApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            ItemRequestModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            HomeView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
        .windowToolbarStyle(UnifiedWindowToolbarStyle(showsTitle: false))
        .windowStyle(HiddenTitleBarWindowStyle())
    }
}
