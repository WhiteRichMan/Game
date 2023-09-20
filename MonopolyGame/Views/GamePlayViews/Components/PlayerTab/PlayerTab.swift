//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//

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
