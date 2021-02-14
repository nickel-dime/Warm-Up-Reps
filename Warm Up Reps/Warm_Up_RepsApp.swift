//
//  Warm_Up_RepsApp.swift
//  Warm Up Reps
//
//  Created by Nikhil Goel on 2/13/21.
//

import SwiftUI

@main
struct Warm_Up_RepsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
