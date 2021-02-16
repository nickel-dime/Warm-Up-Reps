//
//  Exercises.swift
//  Warm Up Reps
//
//  Created by Nikhil Goel on 2/15/21.
//

import SwiftUI

struct Exercises: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Exercise.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.name, ascending: false)]) var exercises: FetchedResults<Exercise>
    
    @State var showingAddExercise = false
    
    var body: some View {
        Group {
            if (exercises.isEmpty) {
                Text("Add some exercises")
                    .italic()
                    .font(.caption)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color(UIColor.systemGroupedBackground))

            } else {
                List {
                    ForEach(exercises) { exercise in
                        Text(exercise.name ?? "")
                    }
                    .onDelete(perform: deleteItems)
                }
                .listStyle(InsetGroupedListStyle())
            
            }
        }
        .navigationBarTitle("Exercises")
        .navigationBarItems(trailing: Button(action: addItem) {
            Image(systemName: "plus")
        })
        .ignoresSafeArea()
        .sheet(isPresented: $showingAddExercise, content: {
            AddExercise()
        })
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { exercises[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            // TODO: Go to new item page
            let newItem = Exercise(context: viewContext)
            newItem.name = "HI"
            newItem.currentWeight = 3
            newItem.increment = 4.0
            
            self.showingAddExercise.toggle()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}



struct Exercises_Previews: PreviewProvider {
    static var previews: some View {
        Exercises()
    }
}
