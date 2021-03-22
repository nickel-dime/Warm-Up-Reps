//
//  ContentView.swift
//  Warm Up Reps
//
//  Created by Nikhil Goel on 2/13/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        // Tab View
        TabView {
            // Workout Tab (for editing workouts)
            NavigationView {
                Exercises()
            }
            .tabItem {
                Image("Workout")
                    .resizable()
                    .imageScale(.small)
                Text("Workouts")
            }
            // Home Tab (for starting a workout and tracking progress)
            NavigationView {
                Exercises()
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("Home")
            }
            NavigationView {
                Exercises()
            }
            .tabItem {
                Image("Dumbell")
                    .resizable()
                    .scaledToFit()
                Text("Exercises")
            }
        }
    }
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
