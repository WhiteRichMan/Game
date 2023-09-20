//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI
import SDWebImageSwiftUI

struct CenterSquareView: View {
   // @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    private var len: CGFloat {
        return  UIScreen.main.bounds.height*0.734
    }
    
    var body: some View {
        // Change the gif based on theme
        WebImage(url: Bundle.main.url(forResource: ("centerSquare2"), withExtension: "gif"), isAnimating: .constant(true))
            .resizable()
            .customLoopCount(0)
            .scaledToFit()
            .frame(width: len, height: len)
    }
}
