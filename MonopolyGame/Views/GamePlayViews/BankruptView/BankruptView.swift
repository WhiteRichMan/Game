/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Thieu Tran Tri Thuc
  ID: s3870730
  Created  date: 15/8/2023
  Last modified: 5/8/2023
  Acknowledgement:
    - The UI components is inspired from:
        Isaac, “Monopoly: Figma community,” Figma, https://www.figma.com/community/file/1223059141348879689/MONOPOLY (accessed Aug. 15, 2023).
    - The UI designs are inspired from:
        This popular Hasbro board game is enjoyed by over a billion people worldwide, We are confident the entire family will fall in love with game night, and MONOPOLY now includes multiplayer video chat. Create a free, “Monopoly - the classic board game on mobile by Marmalade Game Studio,” Marmalade Game Studio, https://www.marmaladegamestudio.com/games/monopoly/ (accessed Aug. 15, 2023).
 */

import SwiftUI

struct BankruptView: View {
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var gameData: GameData
    
    // Get player color
    private var linearColor: LinearGradient {
        switch (gameData.playerList[gameData.currentTurn].colorName) {
        case "green":
            return LinearColorConstant.linearGreen
            
        case "orange":
            return LinearColorConstant.linearRed
            
        case "purple":
            return LinearColorConstant.linearPurple
            
        case "blue":
            return LinearColorConstant.linearBlue
            
        default:
            return LinearColorConstant.linearRed
        }
    }
    
    @Binding var isGameOver: Bool
    
    var body: some View {
        VStack (spacing: 0) {
            Spacer()
            
            // MARK: Rect fill with player's color
            Rectangle()
                .fill(linearColor)
                .frame(width: 120, height: 44)
                .overlay(alignment: .center, content: {
                    // MARK: Circle fill with player color
                    Circle()
                        .fill(linearColor)
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
                                        gameData.playerList[gameData.currentTurn].token
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
            
            // MARK: Bankrupt message
            Rectangle()
                .fill(Color(.black).opacity(0.8))
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .overlay(alignment: .center, content: {
                    Text("\(gameData.playerList[gameData.currentTurn].name) is bankrupt!")
                        .tracking(2)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                    
                }) // end Circle fill with player's color
            
            Divider()
                .frame(width: UIScreen.main.bounds.width, height: 4)
                .background(.white)
            
            Image("Bankrupt")
                .resizable()
                .scaledToFit()
                .frame(height: 180)
                .padding(.top, -25)
            
        } // end Most outer VStack
        .padding(.bottom, 50)
        .onTapGesture {
            dismiss()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                // Move to winning view
                withAnimation() {
                    isGameOver = true
                }
                
                playSound(sound: "winning", type: "mp3", isRepeat: false)
            })
        }
    }
}
