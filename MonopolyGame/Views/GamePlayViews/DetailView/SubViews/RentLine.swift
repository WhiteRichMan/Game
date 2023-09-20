//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct RentLine: View {
    var title: String
    
    var houseNumber: Int
    
    var value: String
    
    private var formattedValue: String {
        return String(format: "%-4d", Int(value)!)
    }
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            ZStack {
                Image("houseIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10)
                    .opacity(0.7)
                
                Text("\(houseNumber)")
                    .font(.system(size: 7, weight: .bold))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Text("$\(formattedValue)")
                .fontWeight(.medium)
                .fontDesign(.monospaced)
        }
    }
}
