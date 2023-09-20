//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import Foundation
import SwiftUI

struct LinearColorConstant {
    static private var silverColors: [Color] = [ Color(red: 0.44, green: 0.44, blue: 0.4),
               Color(red: 0.49, green: 0.49, blue: 0.48),
               Color(red: 0.70, green: 0.71, blue: 0.71),
               Color(red: 0.56, green: 0.55, blue: 0.55),
               Color(red: 0.70, green: 0.71, blue: 0.71),
               Color(red: 0.63, green: 0.64, blue: 0.64)
                ]
    
    static let linearGreen = LinearGradient(
        colors: [Color(red: 0.63, green: 0.86, blue: 0.60), Color(red: 0.35, green: 0.91, blue: 0.25)],
        startPoint: .leading, endPoint: .trailing)
    
    static let linearRed = LinearGradient(
        colors: [Color(red: 1.00, green: 0.62, blue: 0.33), Color(red: 0.90, green: 0.8, blue: 0.4)],
        startPoint: .trailing, endPoint: .leading)
    
    static let linearPurple = LinearGradient(
        gradient: Gradient(
            colors: [Color(red: 0.71, green: 0.40, blue: 0.81), Color(red: 0.71, green: 0.40, blue: 0.81).opacity(0.9)]),
        startPoint: .trailing, endPoint: .leading)
    
    static let linearBlue = LinearGradient(
        colors: [Color(red: 0.04, green: 0.43, blue: 0.80), Color(red: 0.31, green: 0.56, blue: 0.84)],
        startPoint: .trailing, endPoint: .leading)
    
    static let linearSilver = LinearGradient(gradient: Gradient(colors: silverColors), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let linearBlack = LinearGradient(
        colors: [Color(red: 0.14, green: 0.14, blue: 0.14), Color(red: 0.27, green: 0.27, blue: 0.27)],
        startPoint: .bottomLeading, endPoint: .topTrailing)
}
