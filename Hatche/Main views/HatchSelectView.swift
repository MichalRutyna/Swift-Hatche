//
//  HatchSelectView.swift
//  Hatche
//
//  Created by student on 02/06/2025.
//

import SwiftUI

struct HatchSelectView: View {
    
    var onSwitch: () -> Void
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Hatch.score, ascending: true)],
        animation: .default)
    private var hatches: FetchedResults<Hatch>
    
    @State private var selectedHatchImage: String = ""
    @State private var new_hatch_name: String = ""
    @State private var hatch_to_play: String = ""
    @State private var isPlaying: Bool = false
    
    @Binding var chosenHatchObj: Hatch?
    
    let columns = [
        GridItem(.adaptive(minimum: 60)),
        GridItem(.adaptive(minimum: 60)),
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Twoje hatche")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(hatches) { hatch in
                            VStack {
                                Image(hatch.image ?? "1")
                                    .resizable()
                                    .frame(width: 180, height: 180)
                                Text(hatch.type_name ?? "No Name")
                                    .frame(width: 100, height: 20)
                            }.overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(hatch_to_play == hatch.type_name ? Color.green : Color.clear, lineWidth: 3)
                            ).onTapGesture(count: 2) {
                                hatch_to_play = hatch.type_name
                                chosenHatchObj = hatch
                                onSwitch()
                            }.onTapGesture(count: 1) {
                                hatch_to_play = hatch.type_name
                                chosenHatchObj = hatch
                            }
                        }
                    }
                    .padding()
                }
                Button(action: {
                    onSwitch()
                }) {
                    Text("Graj")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(!hatch_to_play.isEmpty ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(hatch_to_play.isEmpty)
                .padding(.horizontal)
                
                Text("Dodaj hatcha")
                    .font(.headline)
                
                HStack {
                    Text("Nazwa:")
                    TextField("Wpisz nazwę", text: $new_hatch_name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onSubmit {
                            addHatch()
                        }
                }
                .padding(.horizontal)
                
                Text("Wybierz obrazek:")
                    .font(.subheadline)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(1...30, id: \.self) { i in
                            let imageName = "\(i)"
                            Image(imageName)
                                .resizable()
                                .frame(width: 80, height: 80)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(selectedHatchImage == imageName ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .onTapGesture {
                                    selectedHatchImage = imageName
                                }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    addHatch()
                }) {
                    Text("Dodaj hatcha")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(validate() ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!validate())
                .padding(.horizontal)
            }
        }
    }
    
    private func validate() -> Bool {
        !new_hatch_name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && !selectedHatchImage.isEmpty
    }
    
    private func addHatch() {
        guard validate() else { return }
        
        let newHatch = Hatch(context: viewContext)
        newHatch.type_name = new_hatch_name
        newHatch.image = selectedHatchImage
        newHatch.score = Int16(hatches.count + 1)
        
        do {
            try viewContext.save()
            new_hatch_name = ""
            selectedHatchImage = ""
        } catch {
            print("Błąd zapisu nowego hatcha: \(error.localizedDescription)")
        }
    }
}
