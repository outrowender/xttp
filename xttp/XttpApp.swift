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
    
    @ObservedObject var model = AppModel()
    
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
                .navigationTitle("Test")
        }
        .modelContainer(sharedModelContainer)
        .windowStyle(.hiddenTitleBar)
        .windowToolbarStyle(.unified)
        .environmentObject(model)
        
        .commands {
            CommandMenu("Debug") {
                Button("Run") {
                    self.model.runAction.toggle()
                }
                .keyboardShortcut("R")
                
                Button("Clean") {
                    self.model.cleanAction.toggle()
                }
                .keyboardShortcut("K", modifiers: [.command, .shift])
            }
            
            CommandGroup(replacing: .newItem) {
                Button("New request") {
                    self.model.addNewAction.toggle()
                }
                .keyboardShortcut("N")
            }
            
            CommandGroup(replacing: .textEditing) {
                Button("Duplicate") {
                    self.model.duplicateAction.toggle()
                }
                .keyboardShortcut("D")
                
                Button("Delete") {
                    self.model.deleteAction.toggle()
                }
                .keyboardShortcut(.delete)
                
                Button("Rename") {
                    self.model.renameAction.toggle()
                }
                .keyboardShortcut(.return)
            }
        }
    }
}
