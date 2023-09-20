//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct CornerView: View {
    var imageName: String
    
    var rotateDegree: Double
    
    var padding: Double
    
    @EnvironmentObject var gameData: GameData
    
    var position: Int
    
    private var len: CGFloat {
        return UIScreen.main.bounds.height*0.132
    }
    
    var body: some View {
        Rectangle()
            .fill(Color(red: 0.80, green: 0.92, blue: 0.8))
            .frame(width: len, height: len)
            .overlay{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(rotateDegree))
                    .padding(padding)
            }
            .border(.black, width: 1)
            .overlay(
                VStack {
                    ForEach(gameData.playerList) { p in
                        if (p.curPos == position) {
                            p.token
                                .frame(width: 25)
                        }
                    }
                }
                     ,alignment: .center)
    }
}
