//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct ContentView: View {
    var body: some View {
        MenuView()
            .onAppear{
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
        .environment(\.locale, .init(identifier: "en"))
        .previewInterfaceOrientation(.landscapeRight)
    }
}
