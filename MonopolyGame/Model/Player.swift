//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import Foundation
import SwiftUI

struct Player: Identifiable, Codable {
    var id: Int = 0
    
    var name: String = ""
    
    var properties: [Property] = []
    
    var money: Int = 1500
    
    var curPos: Int = 0
    
    var colorName: String
    
    var color: Color {
        switch (colorName) {
        case "orange":
            return ColorConstant.orange
            
        case "blue":
            return ColorConstant.blue
            
        default:
            return ColorConstant.orange
        }
    }
    
    var linearColor: LinearGradient {
        switch (colorName) {
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
    
    var tokenName: String
    
    var token: some View {
        Image(self.tokenName)
            .resizable()
            .scaledToFit()
    }
    
    init(id: Int, name: String, money: Int, curPos: Int, tokenName: String, colorName: String) {
        self.id = id
        self.name = name
        self.money = money
        self.curPos = curPos
        self.tokenName = tokenName
        self.colorName = colorName
    }
}
