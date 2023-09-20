//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}

struct MenuView: View {
    @State private var blinking: Bool = false
    
    @State private var showingRule: Bool = false
    
    @State private var showingLDBoard: Bool = false
    
    @State private var showingAchievements: Bool = false
    
    @State var selectedLanguage = "en"
    
    var body: some View {
        // MARK: Main NavigationView
        NavigationView {
            // MARK: ZStack for background
            ZStack {
                Image( UIDevice.isIPad ? "MenuBGPad" : "MenuBackground")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: UIDevice.isIPad ? 0 : -55)
                
                
                    // MARK: Play Game button
                    NavigationLink(destination: GameView()) {
                        Capsule()
                            .fill(LinearColorConstant.linearSilver)
                            .frame(width: UIScreen.main.bounds.height*0.35 + 15, height: UIScreen.main.bounds.width*0.06 + 15)
                            .overlay(alignment: .center, content: {
                                Capsule()
                                    .fill(Color("red"))
                                    .frame(width: UIScreen.main.bounds.height*0.35, height: UIScreen.main.bounds.width*0.06)
                                    .overlay {
                                        Text("PLAY")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: UIDevice.isIPad ? 33 : 23, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    .shadow(color: .gray, radius: 7)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                
                            })
                            .scaleEffect(blinking ? 1.0 : 0.9)
                            .brightness(blinking ? 0.1 : 0.2)
                            .onAppear {
                                // Create animation to blink the button and make it repeate forever
                                let animation = Animation.easeInOut(duration: 1).repeatForever(autoreverses:true)
                                
                                withAnimation(animation) {
                                    // Toggle to blink the button every 1s with animation
                                    blinking = true
                                }
                            }
                    } // end NavigationLink Play Game button
                    // MARK: Action do together with view navigation
                    .simultaneousGesture(TapGesture().onEnded({
                      
                    }))
                    .modifier(Shadown3DModifier())
                    .frame(width: UIScreen.main.bounds.height*0.35 + 15, height: UIScreen.main.bounds.width*0.06 + 15)
                    .offset(x: UIDevice.isIPad ? -50 : 0, y: UIDevice.isIPad ? -50 : 0)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom)
                    .offset(x: -80)
                    
                } // end HStack
                
            } // end ZStack for background
            
        } // end NavigationView
       

    }

