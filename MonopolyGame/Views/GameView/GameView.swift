/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Thieu Tran Tri Thuc
  ID: s3870730
  Created  date: 15/8/2023
  Last modified: 5/9/2023
  Acknowledgement:
    - The UI components is inspired from:
        Isaac, “Monopoly: Figma community,” Figma, https://www.figma.com/community/file/1223059141348879689/MONOPOLY (accessed Aug. 15, 2023).
    - The UI designs are inspired from:
        This popular Hasbro board game is enjoyed by over a billion people worldwide, We are confident the entire family will fall in love with game night, and MONOPOLY now includes multiplayer video chat. Create a free, “Monopoly - the classic board game on mobile by Marmalade Game Studio,” Marmalade Game Studio, https://www.marmaladegamestudio.com/games/monopoly/ (accessed Aug. 15, 2023).
 */

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
                playBackgroundMusic(sound: "bgMusic", type: "mp3")
            }
        }
        // Hide default back button to use custom one
        .navigationBarBackButtonHidden(true)
    }
}
