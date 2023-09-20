/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Thieu Tran Tri Thuc
  ID: s3870730
  Created  date: 15/8/2023
  Last modified: 5/9/2023
  Acknowledgement:
    - The UI components is inspired from:
        Isaac, “Monopoly: Figma community,” Figma, https://www.figma.com/community/file/1223059141348879689/MONOPOLY (accessed Aug. 15, 2023).
    - The UI designs are inspired from:
        This popular Hasbro board game is enjoyed by over a billion people worldwide, We are confident the entire family will fall in love with game night, and MONOPOLY now includes multiplayer video chat. Create a free, “Monopoly - the classic board game on mobile by Marmalade Game Studio,” Marmalade Game Studio, https://www.marmaladegamestudio.com/games/monopoly/ (accessed Aug. 15, 2023).
 */

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
                
                // MARK: Align ment
                HStack {
                    // MARK: 3 button at left side
                    VStack (spacing: UIDevice.isIPad ? 40 : 20) {
                        // MARK: Game Setting button
                        NavigationLink(destination: GameSettingView(selectedLanguage: self.$selectedLanguage)) {
                            Capsule()
                                .fill(.white)
                                .frame(width: UIScreen.main.bounds.height*( UIDevice.isIPad ? 0.25 : 0.35), height: UIScreen.main.bounds.width*0.06)
                                .overlay {
                                    HStack (spacing: 5) {
                                        Image(systemName: "gearshape.fill")
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .heavy))
                                            .foregroundColor(.black)
                                        
                                        Text("Settings")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .bold))
                                            .foregroundColor(.black)
                                            .shadow(color: Color("BlackTransparent"), radius: 7)
                                    }
                                }
                                    
                        } // end Game Setting button
                        .simultaneousGesture(TapGesture().onEnded({
                            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
                        }))
                        .modifier(Shadown3DModifier())
                        
                        // MARK: Leader board button
                        Button(action: {
                            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
                            showingLDBoard.toggle()
                        }, label: {
                            Capsule()
                                .fill(.white)
                                .frame(width: UIScreen.main.bounds.height*( UIDevice.isIPad ? 0.3 : 0.48) , height: UIScreen.main.bounds.width*0.06)
                                .overlay {
                                    HStack (spacing: 5) {
                                        Image(systemName: "trophy.fill")
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .heavy))
                                            .foregroundColor(.black)

                                        Text("Leader Board")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                                .shadow(color: .gray, radius: 7)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                        }) // end LEader Board Button
                        .modifier(Shadown3DModifier())
                        
                        // MARK: Achievements button
                        Button(action: {
                            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
                            showingAchievements.toggle()
                        }, label: {
                            Capsule()
                                .fill(.white)
                                .frame(width: UIScreen.main.bounds.height*( UIDevice.isIPad ? 0.3 : 0.48) , height: UIScreen.main.bounds.width*0.06)
                                .overlay {
                                    HStack (spacing: 5) {
                                        Image(systemName: "medal.fill")
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .heavy))
                                            .foregroundColor(.black)

                                        Text("Achievements")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .bold))
                                            .foregroundColor(.black)
                                    }
                                }
                                .shadow(color: .gray, radius: 7)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                        }) // end LEader Board Button
                        .modifier(Shadown3DModifier())
                        
                        
                        // MARK: Game Rule button
                        Button(action: {
                            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
                            showingRule.toggle()
                        }, label: {
                            Capsule()
                                .fill(.white)
                                .frame(width: UIScreen.main.bounds.height*( UIDevice.isIPad ? 0.3 : 0.48), height: UIScreen.main.bounds.width*0.06)
                                .overlay {
                                    HStack (spacing: 5) {
                                        Image(systemName: "info.circle")
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .heavy))
                                            .foregroundColor(.black)
                                        
                                        Text("Monopoly Rules")
                                            .multilineTextAlignment(.center)
                                            .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .bold))
                                            .foregroundColor(.black)
                                            .shadow(color: Color("BlackTransparent"), radius: 7)
                                    }
                                }
                            
                        }) // end Game Rule button
                        .modifier(Shadown3DModifier())
                        
                    } // end HStack 3 button at left side
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, UIDevice.isIPad ? 0 : -30)
                    .offset(x: UIDevice.isIPad ? UIScreen.main.bounds.width*0.36 : 0)
                    .padding(.top, 50)
                    
                    // MARK: Welcome logo on top
                    Image("WelcomeLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.top,  UIDevice.isIPad ? -100 : -60)
                
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
                        playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
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
        .navigationViewStyle(StackNavigationViewStyle())
        // MARK: Sheet to display game rule
        .sheet(isPresented: $showingRule) {
            RuleView()
                .scaleEffect(UIDevice.isIPad ? 1.5 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        // MARK: Sheet to display leader board
        .sheet(isPresented: $showingLDBoard) {
            LeaderBoardView()
                .scaleEffect(UIDevice.isIPad ? 1.5 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        // MARK: Sheet to display Achievements
        .sheet(isPresented: $showingAchievements) {
            AchievementView()
                .scaleEffect(UIDevice.isIPad ? 1.5 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        // MARK: Define language for all child views
        .environment(\.locale, .init(identifier: selectedLanguage))
        // MARK: Default action when view appear
        .onAppear {
            self.selectedLanguage = UserDefaults.standard.string(forKey: "language") ?? "en"
            
            playBackgroundMusic(sound: "bgMusic", type: "mp3")
            
            UserDefaults.standard.setValue(100, forKey: "numberGamePlayed")
            
        }

    }
}
