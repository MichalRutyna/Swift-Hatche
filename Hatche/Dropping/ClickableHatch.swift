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
    
    @State private var clicks: Int = 0
    @State private var every_x_clicks: Int = 8
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var imageName: String

    var body: some View {
        VStack {
        Image(imageName)
            .resizable()
            .frame(width: 150, height: 150)
            .onTapGesture(count: 1) {
                clicks = clicks + 1
                if (clicks >= every_x_clicks) {
                    showFloatingPopup()
                    clicks = 0
                    every_x_clicks = Int(Int.random(in: 2...15))
                }
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
        ProgressView(value: Float(clicks) / Float(every_x_clicks))
            Text("\(clicks)/\(every_x_clicks)")
            
        }
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
