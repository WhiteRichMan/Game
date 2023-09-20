//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    var property: Property
    
    var dismissButton: Bool
    
    // Define the width and heigth based on the screen size
    private var width: CGFloat {
        return  UIScreen.main.bounds.height*0.4
    }
    
    private var height: CGFloat {
        return width/0.618
    }
    
    private var textColor: Color {
        return .black
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .frame(width: width+20, height: height+25)
                .border(.black)
            
            Rectangle()
                .fill( (property.type == "tax") ? Color(red: 0.80, green: 0.92, blue: 0.8) : .white)
                .frame(width: width, height: height)
                .overlay{
                    // MARK: Street property
                    if (property.type == "street") {
                        StreetDetailView(property: self.property, width: self.width, height: self.height)
                    }
                    // MARK: Railroad property
                    else if (property.type == "railroad") {
                        RailRoadDetailView(property: self.property, width: self.width, height: self.height)
                    }
                    // MARK: Taxes space
                    else if (property.type == "tax") {
                        if (property.name == "Luxury Tax") {
                            Image("luxuryTax")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.4, height: UIScreen.main.bounds.height*0.4/0.618)
                        }
                        else if (property.name == "Income Tax") {
                            Image("IncomeTax")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.height*0.4, height: UIScreen.main.bounds.height*0.4/0.618)
                                .brightness(0.1)
                        }
                    }
                } // end Rectangle
        } // End first ZStack
        .frame(width: width+40, height: height+45)
        .foregroundColor(textColor)
        .background(.white)
        // MARK: Custom cancle button
        .overlay(alignment: .topTrailing, content: {
            if (dismissButton) {
                Circle()
                    .fill(.white)
                    .frame(width: 30)
                    .overlay(
                        Button(action: {
                            dismiss()
                            
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 30, weight: .heavy))
                        })
                        , alignment: .center)
                    .foregroundColor(.black)
                    .offset(x: 20, y: -20)
            }
            else {
                EmptyView()
            }
        })
    }
}
