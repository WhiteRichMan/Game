//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct HorizontalCell: View {
    var property: Property
    
    @EnvironmentObject var gameData: GameData
    
    @Binding var isBuildingMode: Bool
    
    private var width: CGFloat {
        return  UIScreen.main.bounds.height*0.132
    }
    
    private var height: CGFloat {
        return width*0.618
    }
    
    var body: some View {
        // Reuse the Vertical view and rotate to input direction
        VeritalCell(property: property, isBuildingMode: self.$isBuildingMode)
            .frame(width: width, height: height)
            .rotationEffect(.degrees(90))
    }
}
