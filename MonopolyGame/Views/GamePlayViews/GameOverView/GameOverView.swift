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

struct GameOverView: View {
    @Environment(\.dismiss) var dismiss
    
    // Use the same gamedata with parent views
    @EnvironmentObject var gameData: GameData
    
    @Binding var backMenu: Bool
    
    private var winner: Player {
        return gameData.playerList[gameData.currentTurn == 0 ? 1: 0]
    }
    
    var body: some View {
        // MARK: Most outer ZStack
        ZStack {
            Image("FocusStageLight")
                .resizable()
                .scaledToFit()
            
            // MARK: Main VStack
            VStack (spacing: 0) {
                Spacer()
                
                // MARK: Rect fill with player's color
                Rectangle()
                    .fill(winner.linearColor)
                    .frame(width: 120, height: 44)
                    .overlay(alignment: .center, content: {
                        // MARK: Circle fill with player color
                        Circle()
                            .fill(winner.linearColor)
                            .frame(width: 75, height: 75)
                            .overlay(alignment: .center, content: {
                                // MARK: Circle fill white
                                Circle()
                                    .fill(.white)
                                    .frame(width: 65, height: 65)
                                    .overlay(alignment: .center, content: {
                                        // MARK: VStack contains player's token and name
                                        VStack (spacing: 0) {
                                            // Player token
                                            winner.token
                                                .frame(width: 55)
                                            
                                        } // end VStack contains player's token and name
                                        .frame(width: 120)
                                        
                                    }) // end Circle fill white
                                
                            }) // end Circle fill with player's color
                            .padding(.trailing, 4)
                        
                    }) // end Rect fill with player's color
                    .modifier(Shadown3DModifier())
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width, height: 4)
                    .background(.white)
                
                // MARK: Winner announcement
                Rectangle()
                    .fill(Color(.black).opacity(0.8))
                    .frame(width: UIScreen.main.bounds.width, height: 80)
                    .overlay(alignment: .center, content: {
                        Text("\(winner.name) is the winner!")
                            .tracking(2)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.white)
                        
                    })
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width, height: 4)
                    .background(.white)
                
                Image("winning")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 180)
                    .padding(.top, -25)
                
            } // end Main VStack
            
        } // end Most outer ZStack
        .padding(.bottom, 50)
        // MARK: Tap to end the view
        .onTapGesture {
            backMenu = true
            dismiss()
        }
    }
}
