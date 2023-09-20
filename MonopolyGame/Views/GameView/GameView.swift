//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct GameView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    // Variable to let ModeSelectionView and Board View back directly to Menu View
    @State var backMenu: Bool = false
    
    @State var displayModeSelection: Bool = true
    
    // Initialize gamedata for ModeSelectionView configure and BoardView using
    @StateObject var gameData: GameData = GameData(mode: "twoPlayer")
    
    @State var isNewGame: Bool = false
    
    var body: some View {
        // Display Mode selectionview by default
        ZStack {
            if (displayModeSelection) {
                ModeSelectionView(backMenu: self.$backMenu, displayModeSelection: self.$displayModeSelection)
            }
            else {
                BoardView(backMenu: self.$backMenu)
            }
        }
        .environmentObject(gameData)
        // If user press back button on this view or in ModeSelectionView or BoardView
        .onChange(of: backMenu) {newValue in
            if (backMenu) {
                self.presentationMode.wrappedValue.dismiss()
                
            }
        }
        // Hide default back button to use custom one
        .navigationBarBackButtonHidden(true)
    }
}
