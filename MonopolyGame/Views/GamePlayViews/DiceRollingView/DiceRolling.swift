//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct DiceRolling: View {
    @Environment(\.dismiss) var dismiss
    
    // Store 2 dices value
    @Binding var dices: [Int]
    
    // Timer publish to get random number
    let rollingTimer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    // TImer to stop the rolling
    let counterTimer = Timer.publish(every: 2, on: .main, in: .common).autoconnect()
    
    @State private var value1: Int = 0
    
    @State private var value2: Int = 0
    
    // Image array
    let diceImages: [String] = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var body: some View {
        // MARK: ZStack to cover dices, prevent gestures from users
        ZStack {
            // MARK: Dices
            HStack (spacing: 5) {
                // MARK: First dice
                TabView (selection: $value1.animation()) {
                    ForEach(0...5) { id in
                        Image("\(diceImages[id])")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width*0.3)
                            .opacity(1.0)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(.clear)
                .onReceive(rollingTimer, perform: {_ in
                    value1 = Int.random(in: 0...5)
                }) // end First Dice
                
                // MARK: Second dice
                TabView (selection: $value2.animation()) {
                    ForEach(0...5) { id in
                        Image("\(diceImages[id])")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width*0.3)
                            .opacity(1.0)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(.clear)
                .onReceive(rollingTimer, perform: {_ in
                    value2 = Int.random(in: 0...5)
                }) // end Second Dice
                
            } // end HStack Dices
            // End rolling animation after 2s
            .onReceive(counterTimer, perform: {_ in
                self.rollingTimer.upstream.connect().cancel()
                
                // Save final value to send back to parent view
                dices[0] = value1+1
                dices[1] = value2+1
                
                // Delay the start of animation 1s
                 DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                     dismiss()
                 })
            })
            .onAppear {
                
            }
            
            Color(.cyan)
                .opacity(0.0)
        } //end 1st ZStack
    }
}
