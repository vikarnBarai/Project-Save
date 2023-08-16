//
//  ProjectSaveApp.swift
//  ProjectSave
//
//  Created by Vikarn Barai on 27/07/23.
//

import SwiftUI

@main
struct ProjectSaveApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ProjectListView(viewModel: ProjectViewModel())
                .environment(\.managedObjectContext, PersistenceManager.shared.context)
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                PersistenceManager.shared.saveContext()
            }
        }
    }
    
}
