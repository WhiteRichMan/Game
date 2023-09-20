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

struct PlayerTab: View {
    @EnvironmentObject var gameData: GameData
    
    var playerIdx: Int
    
    private var linearColor: LinearGradient {
        switch (gameData.playerList[playerIdx].colorName) {
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
    
    var body: some View {
        ZStack {
            // MARK: 1st Rectangle fill white
            Rectangle()
                .fill(.white)
                .frame(width: 100, height: 60)
                .cornerRadius(10, corners: [.bottomLeft])
                .overlay(alignment: .topTrailing, content: {
                    // MARK: VStack with bottm is current player's current money
                    VStack (spacing: 0) {
                        // MARK: Rect fill with player's color
                        Rectangle()
                            .fill(linearColor)
                            .frame(width: 120, height: 44)
                            .overlay(alignment: .bottomTrailing, content: {
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
                                                    gameData.playerList[playerIdx].token
                                                        .frame(width: 55)
                                                    
                                                } // end VStack contains player's token and name
                                                .frame(width: 120)
                                                
                                            }) // end Circle fill white
                                        
                                        Rectangle()
                                            .fill(linearColor)
                                            .frame(width: 110, height: 20)
                                            .frame(maxHeight: .infinity, alignment: .bottom)
                                            .overlay(alignment: .bottomLeading, content: {
                                                Text(gameData.playerList[playerIdx].name)
                                                    .font(.system(size: 15, weight: .heavy, design: .rounded))
                                                    .foregroundColor(.white)
                                                    .frame(maxWidth: .infinity)
                                            })
                                        
                                    }) // end Circle fill with player's color
                                    .padding(.trailing, 4)
                                
                            }) // end Rect fill with player's color
                        
                        Text("$\(String(gameData.playerList[playerIdx].money))")
                            .font(.system(size: 14, weight: .heavy, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        
                    } // end VStack with bottm is current player's current money
                    
                }) // end 1st Rectangle fill white
        }
    }
}
