//
//  AddExercise.swift
//  Warm Up Reps
//
//  Created by Nikhil Goel on 2/16/21.
//

import SwiftUI

struct AddExercise: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var currentWeightString = ""
    @State private var increment = 0.0
    
    @State var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of Exercise", text: $name)
                    
                }
                Section(header: Text("Current Weight"), content: {
                    // TODO:
                    // 1. fix textField for number
                    // 2. dismiss keyboard on tap
                    TextField("Current Weight", text: $currentWeightString)
                        .keyboardType(.decimalPad)

                })
                Section(header: Text("Increment"), content: {
                    VStack {
                        HStack {
                            Text("0")
                            Slider(value: $increment, in: 0...10, step: 0.5)
                            Text("10")
                        }
                        Text(String(format: "%.1f", increment))
                        
                    }
                })
                Section {
                    Button(action: {
                        self.validate()
                    }, label: {
                        Text("Save")
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    })
                    
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Error"), message: Text("Invalid Field"), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("Add Exercise")
        }
    }
    
    func validate() {
        let currentWeight = Double(self.currentWeightString)
        if (!self.name.isEmpty && currentWeight != 0) {
            let newExercise = Exercise(context: self.moc)
            newExercise.name = self.name
            newExercise.currentWeight = currentWeight ?? 0
            newExercise.increment = Double(self.increment)
            
            if self.moc.hasChanges {
                try? self.moc.save()
            }
            self.presentationMode.wrappedValue.dismiss()
            
        } else {
            self.showingAlert = true
        }
        
    }
}


struct AddExercise_Previews: PreviewProvider {
    static var previews: some View {
        AddExercise()
    }
}
