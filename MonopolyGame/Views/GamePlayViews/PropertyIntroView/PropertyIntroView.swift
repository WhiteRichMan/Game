//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct PropertyIntroView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var buying: Int
    
    var property: Property
    
    @StateObject var gameData: GameData
    
    var body: some View {
        // MARK: Most outer VStack
        VStack (spacing: 10) {
            // MARK: Property detail and decor view
            HStack {
                DetailView(property: property, dismissButton: false)
                    .scaleEffect(0.9)
                    .rotationEffect(.degrees(-5))
                    .padding(.leading, 20)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
                Spacer()
                
                // MARK: Decor view
                ZStack {
                    //MARK: Price
                    ZStack {
                        Image(systemName: "bubble.right.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.white)
                        
                        Text("$\(property.cost)")
                            .font(.system(size: 25, weight: .bold))
                            .padding(.bottom)
                    } // end ZStack Price
                    .frame(maxHeight: .infinity, alignment: .top)
                    .offset(x: -60, y: 80)
                    
                    Image("IntroducePrice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.height*0.35, alignment: .bottom)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.trailing)
                } // end ZStack Decor view
                .frame(maxHeight: .infinity)
            } // end 1st HStackProperty detail and decor view
            .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width*0.4)
            
            //MARK: Options bar
            HStack (spacing: 40) {
                // MARK: Buy button
                Capsule()
                    .fill(Color("red"))
                    .frame(width: UIScreen.main.bounds.height*0.35, height: UIScreen.main.bounds.width*0.06)
                    .overlay {
                        Button(action: {
                            buying = 1
                            dismiss()
                        }, label: {
                            Text("BUY $\(property.cost)")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 23, weight: .bold))
                                .foregroundColor(.white)
                        })
                    } // end Buy button
                    .padding(.leading)
                    .disabled( (gameData.playerList[gameData.currentTurn].money < Int(property.cost)! ))
                    .opacity( (gameData.playerList[gameData.currentTurn].money < Int(property.cost)! ) ? 0.6 : 1.0)
                
                // MARK: Dont buy button
                Capsule()
                    .fill(.black)
                    .frame(width: UIScreen.main.bounds.height*0.35, height: UIScreen.main.bounds.width*0.06)
                    .overlay {
                        Button(action: {
                            
                            buying = 2
                            dismiss()
                        }, label: {
                            HStack (spacing: 0) {
                                Image(systemName: "xmark")
                                    .font(.system(size: 20, weight: .heavy))
                                    .foregroundColor(.white)
                                
                                Text("DON'T BUY")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 17, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        })
                    } // end Dont buy button
                    .padding(.trailing)
                
            } // end HStack Options bar
        } // end 1st VStack
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width*0.5)
        .padding(.bottom, 20)
        .onAppear {
            
        }
    }
}
