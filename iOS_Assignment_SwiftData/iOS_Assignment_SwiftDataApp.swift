//
//  iOS_Assignment_SwiftDataApp.swift
//  iOS_Assignment_SwiftData
//
//  Created by Muthuraman Vairavan on 28/08/24.
//

import SwiftUI
import SwiftData

@main
struct iOS_Assignment_SwiftDataApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            PhotoInfoModel.self
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
            CategoryListView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
