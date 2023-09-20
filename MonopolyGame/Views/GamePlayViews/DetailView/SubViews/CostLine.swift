//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI
import Foundation

struct CostLine: View {
    var text: String
    
    var value: String
    
    private var formattedValue: String {
        return String(format: "%-4d", Int(value)!)
    }
    
    var body: some View {
        HStack {
            Text(LocalizedStringKey(text))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            Text("$\(formattedValue)")
                .fontWeight(.medium)
                .fontDesign(.monospaced)
            
        }
    }
}
