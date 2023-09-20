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
    
    // Below is functions for decoding and encoding purposes
//    enum CodingKeys: CodingKey {
//        case id, name, money, properties, curPos, colorName, color, tokenName, token
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(money, forKey: .money)
//        try container.encode(properties, forKey: .properties)
//        try container.encode(curPos, forKey: .curPos)
//        try container.encode(colorName, forKey: .colorName)
//        try container.encode(tokenName, forKey: .tokenName)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try container.decode(Int.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        money = try container.decode(Int.self, forKey: .money)
//        properties = try container.decode([Property].self, forKey: .properties)
//        curPos = try container.decode(Int.self, forKey: .curPos)
//        colorName = try container.decode(String.self, forKey: .colorName)
//        tokenName = try container.decode(String.self, forKey: .tokenName)
//    }
}
