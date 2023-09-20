//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct ResumeGameView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var option: Int
    
    var body: some View {
        // MARK: Most outer Vstack
        VStack (spacing: 0) {
            // MARK: Title
            VStack (spacing: 0) {
                // MARK: Title
                Rectangle()
                    .fill(Color("red"))
                    .frame(width: UIScreen.main.bounds.width*( UIDevice.isIPad ? 0.45 : 0.5), height: UIDevice.isIPad ? 120 : 50)
                    .cornerRadius(15, corners: [.topLeft, .topRight])
                    .overlay(alignment: .center, content: {
                        Text("Resume games?")
                            .font(.system(size:  UIDevice.isIPad ? 37 : 25, weight: .heavy))
                            .foregroundColor(.white)
                    })
                    .padding(.top, -3)
                
                Divider()
                    .frame(width: UIScreen.main.bounds.width*( UIDevice.isIPad ? 0.45 : 0.5), height: 5)
                    .background(LinearColorConstant.linearSilver)
            } // end  VStack Title
            
            // MARK: Message text
            Rectangle()
                .fill(.white)
                .frame(width: UIScreen.main.bounds.width*( UIDevice.isIPad ? 0.45 : 0.5), height: UIScreen.main.bounds.height*( UIDevice.isIPad ? 0.32 : 0.45))
                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                .overlay(alignment: .center, content: {
                    Text("There is a game in progress.")
                        .font(.system(size:  UIDevice.isIPad ? 35 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(.black)
                })
            
            //MARK: Options bar
            HStack (spacing: 40) {
                // MARK: New game button
                Capsule()
                    .fill(.black)
                    .frame(width: UIScreen.main.bounds.height*(UIDevice.isIPad ? 0.26 : 0.35), height: UIScreen.main.bounds.width*0.06)
                    .overlay {
                        Button(action: {
                            
                            option = 1
                            dismiss()
                        }, label: {
                            Text("NEW GAME")
                                .multilineTextAlignment(.center)
                                .font(.system(size: UIDevice.isIPad ? 32 : 20, weight: .bold))
                                .foregroundColor(.white)
                        })
                    }
                    .padding(.trailing)
                    .modifier(Shadown3DModifier())
                
                // MARK: Resume button
                Capsule()
                    .fill(Color("red"))
                    .frame(width: UIScreen.main.bounds.height*(UIDevice.isIPad ? 0.26 : 0.35), height: UIScreen.main.bounds.width*0.06)
                    .overlay {
                        Button(action: {
                            
                            option = 2
                            dismiss()
                        }, label: {
                            Text("RESUME")
                                .multilineTextAlignment(.center)
                                .font(.system(size: UIDevice.isIPad ? 32 : 20, weight: .bold))
                                .foregroundColor(.white)
                        })
                    }
                    .padding(.leading)
                    .modifier(Shadown3DModifier())
                
            } // end HStack Options bar
            .offset(y: -20)
            
        } // end Most outer Vstack
        // MARK: Cancle button
        .overlay(alignment: .topTrailing, content: {
            Circle()
                .fill(.white)
                .frame(width: UIDevice.isIPad ? 50 : 40)
                .overlay(
                    Button(action: {
                        
                        dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: UIDevice.isIPad ? 50 : 40, weight: .heavy))
                    })
                    , alignment: .center)
                .foregroundColor(.black)
                .offset(x:  UIDevice.isIPad ? 10 : 20, y:  UIDevice.isIPad ? -20 : -20)
                .modifier(Shadown3DModifier())
        })
        .modifier(Shadown3DModifier())
        .padding(.top, 40)
    }
}
