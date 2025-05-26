//
//  ClickableHatch.swift
//  Hatche
//
//  Created by student on 26/05/2025.
//

import SwiftUI

struct ClickableHatch: View {
    @State private var showPopup = false
    @State private var dropped_item: Equipment?
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .frame(width: 150, height: 150)
            .onTapGesture(count: 2) {
                showFloatingPopup()
            }
            .overlay {
                if showPopup {
                    Image(dropped_item!.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .transition(.scale.combined(with: .opacity))
                        .offset(y: -100)  // floating above image
                }
            }
            .animation(.easeInOut, value: showPopup)
    }

    func showFloatingPopup() {
        dropped_item = getRandomItem(in: viewContext)
        if ((dropped_item == nil))
        {
            print("Dropped nil")
        }
        withAnimation {
            showPopup = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation {
                showPopup = false
            }
        }
    }

}
