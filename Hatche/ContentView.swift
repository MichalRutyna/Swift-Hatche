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
        sortDescriptors: [NSSortDescriptor(keyPath: \Equipment.score, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Equipment>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item \(item.name) ")
                    } label: {
                        Text(item.name)
                    }
                }
            }
            
        }
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
