//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct ModeSelectionView: View {
    // Use
    @EnvironmentObject var gameData: GameData
    
    @Binding var backMenu: Bool
    
    @Binding var displayModeSelection: Bool
    
    @State var displayResumeWindow: Bool = false
    
    @State var option: Int = 0
    
    @State private var selectingMode: String = ""
    
    var backButton : some View {
        Button(action: {
            self.backMenu = true
        })  {
            Circle()
                .fill(LinearColorConstant.linearBlack)
                .frame(height:  UIDevice.isIPad ? 55 : 40)
                .overlay(alignment: .center, content: {
                    Image(systemName: "arrowshape.backward.fill")
                        .foregroundColor(.white)
                        .font(.system(size:  UIDevice.isIPad ? 34 : 24, weight: .medium))
                    
                })
                .foregroundColor(.black)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        }
        .contentShape(Circle())
        .padding(.top)
        .padding(.trailing, 20)
        
    }
    
    var body: some View {
        // MARK: Most outer ZStack for background
        ZStack {
            // MARK: Main VStack
            VStack (spacing: 0) {
                // MARK: Title
                VStack (spacing: 0) {
                    // MARK: Title
                    ZStack {
                        Rectangle()
                            .fill(Color("red"))
                            .frame(width: UIScreen.main.bounds.width, height: UIDevice.isIPad ? UIScreen.main.bounds.height*0.1 : 60)
                            .overlay(alignment: .center, content: {
                                Text("Select Mode")
                                    .font(.system(size:  UIDevice.isIPad ? 35: 25, weight: .heavy))
                                    .foregroundColor(.white)
                            })
                        
                        backButton
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 50)
                            .padding(.top, -12)
                    } // end ZStack title
                    
                    Divider()
                        .frame(width: UIScreen.main.bounds.width, height:  UIDevice.isIPad ? 10 : 5)
                        .background(LinearColorConstant.linearSilver)
                }
                .offset(y: UIDevice.isIPad ? -25 : 0)
                
                Spacer()
                
                // MARK: Mode List
                HStack (spacing: 20) {
                    // MARK: Single PLayer mode
                    Image("singlePlayerOption")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25, corners: [.topLeft, .bottomRight])
                        .frame(height: UIScreen.main.bounds.height*0.7)
                        .overlay(alignment: .bottom, content: {
                            VStack (spacing: UIDevice.isIPad ? 85 : 20) {
                                Text("Challenge our AI\nplayers")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: UIDevice.isIPad ? 30 : 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                                // MARK: Single Player Button
                                Capsule()
                                    .fill(.white)
                                    .frame(width: 150*( UIDevice.isIPad ? 2.2 : 1), height: UIScreen.main.bounds.width*(UIDevice.isIPad ? 0.08 : 0.05))
                                    .overlay {
                                        HStack (spacing: 5) {
                                            Text("Coming soon!")
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: UIDevice.isIPad ? 28 : 16, weight: .bold))
                                                .foregroundColor(.red)
                                                .shadow(color: Color("BlackTransparent"), radius: 7)
                                        }

                                    }
                                    .disabled(true)
                                    .opacity(0.8)
                            }
                            .padding(.bottom,  UIDevice.isIPad ? 80 : 25)
                        }) // end Single PLayer mode
                    
                    // MARK: Two player mode
                    Image("passPlayOption")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(25, corners: [.topLeft, .bottomRight])
                        .frame(height: UIScreen.main.bounds.height*0.7)
                        .overlay(alignment: .bottom, content: {
                            VStack (spacing: UIDevice.isIPad ? 85 : 20) {
                                Text("Pass one device\nbetween players")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: UIDevice.isIPad ? 30 : 18, weight: .bold))
                                    .foregroundColor(.white)
                                
                                
                                // MARK: Pass&Play Player Button
                                Button(action: {
                                    selectingMode = "twoPlayer"
                                    checkGameSave(mode: selectingMode)
                                }, label: {
                                    Capsule()
                                        .fill(.white)
                                        .frame(width: 150*( UIDevice.isIPad ? 2 : 1), height: UIScreen.main.bounds.width*(UIDevice.isIPad ? 0.08 : 0.05))
                                        .overlay {
                                            HStack (spacing: 5) {
                                                Text("Pass & Play")
                                                    .multilineTextAlignment(.center)
                                                    .font(.system(size: UIDevice.isIPad ? 28 : 16, weight: .bold))
                                                    .foregroundColor(.red)
                                                    .shadow(color: Color("BlackTransparent"), radius: 7)
                                            }

                                        }
                            })
                        }
                        .padding(.bottom,  UIDevice.isIPad ? 80 : 25)
                        }) // end Two player mode
                    
                } // end HStack Mode List
                .padding(.bottom, UIDevice.isIPad ? 75 : 10)
                
            } // end Main VStack
                
        } // end Most outer ZStack for background
        .sheet(isPresented: $displayResumeWindow) {
            ResumeGameView(option: self.$option)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        .onChange(of: self.option) { newValue in
            if (option == 1) {
                gameData.loadData(isNewGame: true, mode: selectingMode)
            }
            else if (option == 2) {
                gameData.loadData(isNewGame: false, mode: selectingMode)
            }
            
            withAnimation() {
                self.displayModeSelection = false
            }
        }
    }
    
    func checkGameSave(mode: String) {
        if (UserDefaults.standard.data(forKey: mode) != nil) {
            withAnimation() {
                self.displayResumeWindow = true
            }
        }
        else {
            withAnimation() {
                self.displayModeSelection = false
            }
        }
    }
}
