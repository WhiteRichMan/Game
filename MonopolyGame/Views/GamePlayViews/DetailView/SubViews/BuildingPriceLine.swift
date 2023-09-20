//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct BuildingPriceLine: View {
    var imageName: String
    
    var title: String
    
    var value: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .opacity(0.7)
            .frame(width: 10)
        
        Text(LocalizedStringKey(title))
            .multilineTextAlignment(.center)
            .padding(.leading, 2)
        
        Spacer()
        
        Text("$\(value)")
    }
}
