//
//  ContentView.swift
//  Hatche
//
//  Created by student on 05/05/2025.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hatch.score, ascending: true)],
        animation: .default)
    private var hatches: FetchedResults<Hatch>
    @State private var selectedHatch: String = "Marcin"
    @State private var new_hatch_name: String = ""
    
    var body: some View {
        VStack{
            Picker("hatch", selection: $selectedHatch){
                ForEach(hatches) { hatch in
                    HStack() { // spacing między obrazkiem a tekstem
                        Image(hatch.image)
                            .resizable()
                            .rotationEffect(Angle(degrees: -90))
                            .frame(width: 30, height: 30)
                        Text(hatch.type_name)
                            .tag(hatch.type_name)
                            .rotationEffect(Angle(degrees: -90))
                            .scaleEffect(0.2)
                        
                        
                    }
                    .frame(height: 300)
                    
                }
            }
            .pickerStyle(.wheel)
            .scaleEffect(3)
            .frame(width: 120, height: 100)
            .rotationEffect(Angle(degrees: 90))
            
            Text("Nazwa: ")
            TextField("Twuj stary", text: $new_hatch_name)
                .onSubmit {
                    if(validate()){
                        print("Dobra nazwa")
                    }
                }
        }
    }
    
    func validate() -> Bool
    {
        return !new_hatch_name.isEmpty
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}


