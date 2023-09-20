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
import Combine

enum Theme {
    static let darkMode = false
}

enum Language {
    static let language = "en"
}

struct GameSettingView: View {
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custome back button to dismiss the view.
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var selectedLanguage: String
    
    // Save systemTheme to AppStorage to save user option for the next using and access from other view
    @AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @State var player1Name: String = ""
    
    @State var player2Name: String = ""
    
    @State var gettingUserInput: Bool = false
    
    private let textLimit = 10
    
    private let titleSize: CGFloat = UIDevice.isIPad ? 30 : 18
    
    private let arrowButtonSize: CGFloat = UIDevice.isIPad ? 45 : 30
    
    private let titleContentSpacing: CGFloat = UIDevice.isIPad ? 30 : 10
    
    var backButton : some View {
        Button(action: {
            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
            saveSettings()
            
            self.presentationMode.wrappedValue.dismiss()
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
            Image(UIDevice.isIPad ? "whiteBGPad" : "whiteBG")
                .resizable()
                .scaledToFit()
                .edgesIgnoringSafeArea(.all)
            
            // MARK: Main VStack
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    // MARK: Title
                    ZStack {
                        Rectangle()
                            .fill(Color("red"))
                            .frame(width: UIScreen.main.bounds.width, height: UIDevice.isIPad ? UIScreen.main.bounds.height*0.1 : 60)
                            .overlay(alignment: .center, content: {
                                Text("Settings")
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
                
                VStack (spacing: UIDevice.isIPad ? 100 : 30) {
                    // MARK: HSTACK PLayers name
                    HStack (spacing: UIDevice.isIPad ? 80 : 50) {
                        // MARK: Player 1 name
                        VStack (spacing: titleContentSpacing) {
                            Text("Player 1:")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.system(size: titleSize, weight: .semibold))
                            
                            Capsule()
                                .fill(.black)
                                .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.height*(UIDevice.isIPad ? 0.1 : 0.13) )
                                .overlay(alignment: .center, content: {
                                    TextField("Player 1 Name", text: $player1Name)
                                        .foregroundColor(.white)
                                        .font(.system(size: UIDevice.isIPad ? 30 : 20, weight: .bold, design: .rounded))
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .onReceive(Just(player1Name)) {_ in
                                            limitText(textLimit)
                                        }
                                })
                                .modifier(Shadown3DModifier())
                        } // end Player 1 name
                        
                        // MARK: Player 2 name
                        VStack (spacing: titleContentSpacing) {
                            Text("Player 2:")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.system(size:  UIDevice.isIPad ? 28 : 18, weight: .semibold))
                            
                            Capsule()
                                .fill(.black)
                                .frame(width: UIScreen.main.bounds.width*0.3, height: UIScreen.main.bounds.height*(UIDevice.isIPad ? 0.1 : 0.13))
                                .overlay(alignment: .center, content: {
                                    TextField("Player 2 Name", text: $player2Name)
                                        .foregroundColor(.white)
                                        .font(.system(size: titleSize, weight: .bold, design: .rounded))
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .onReceive(Just(player2Name)) {_ in
                                            limitText(textLimit)
                                        }
                                })
                                .modifier(Shadown3DModifier())
                            
                        } // end VStack Player 2 name
                        
                    } // end HSTACK PLayers name
                    
                    // MARK: Language selection and theme toggle switch
                    HStack (spacing: UIDevice.isIPad ? 150 : 80) {
                        // MARK: Language setting
                        VStack (spacing: titleContentSpacing) {
                            Text("Language")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.system(size: titleSize, weight: .semibold, design: .rounded))
                            
                            // MARK: Language selection
                            HStack (spacing: 0) {
                                Button(action: {
                                    playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
                                    selectedLanguage = selectedLanguage == "en" ? "vi" : "en"
                                }, label: {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: arrowButtonSize, height: arrowButtonSize)
                                        .overlay(alignment: .center, content: {
                                            Image(systemName: "arrowtriangle.left.fill")
                                                .font(.system(size: UIDevice.isIPad ? 25 : 15, weight: .bold))
                                                .foregroundColor(.black)
                                        })
                                        .modifier(Shadown3DModifier())
                                })
                                
                                // MARK: Display current language
                                Text("English (en)")
                                    .font(.system(size: UIDevice.isIPad ? 34 : 20, weight: .bold))
                                    .frame(width: UIScreen.main.bounds.width*0.22)
                                
                                Button(action: {
                                    playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
                                    selectedLanguage = selectedLanguage == "en" ? "vi" : "en"
                                }, label: {
                                    Circle()
                                        .fill(.white)
                                        .frame(width: arrowButtonSize, height: arrowButtonSize)
                                        .overlay(alignment: .center, content: {
                                            Image(systemName: "arrowtriangle.right.fill")
                                                .font(.system(size: UIDevice.isIPad ? 25 : 15, weight: .bold))
                                                .foregroundColor(.black)
                                        })
                                        .modifier(Shadown3DModifier())
                                })
                            } // end HStack Language selection
                            
                        } // end VStack Language setting
                        
                        // MARK: Theme toggle switch
                        VStack (spacing: titleContentSpacing) {
                            Text("Dark Mode")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .font(.system(size: titleSize, weight: .semibold, design: .rounded))
                            
                            Toggle("DarkMode", isOn:$isDarkMode)
                                .scaleEffect(UIDevice.isIPad ? 2 : 1.2)
                                .toggleStyle(SwitchToggleStyle(tint: .red))
                                .frame(width: UIDevice.isIPad ? 100 : 80, height: UIDevice.isIPad ? 50 : 40)
                                .labelsHidden()
                                .modifier(Shadown3DModifier())
                        } // end Theme toggle switch
                    } // end HStack Language selection and theme toggle switch
                    
                    // MARK: Difficulty selection
                    HStack {
                        DifficultyDropdownMenu()
                            .modifier(Shadown3DModifier())
                    } // end HStack Difficulty selection
                    
                    Spacer()
                }
            } // end Main VStack
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            loadSettings()
        }

    }
    
    //Function to keep text length in limits
    func limitText(_ upper: Int) {
        if player1Name.count > upper {
            player1Name = String(player1Name.prefix(upper))
        }
        
        if player2Name.count > upper {
            player2Name = String(player2Name.prefix(upper))
        }
    }
    
    // Function to load setting from storage
    func loadSettings() {
        self.player1Name = UserDefaults.standard.string(forKey: "player1Name") ?? "Player 1"
        
        self.player2Name = UserDefaults.standard.string(forKey: "player2Name") ?? "Player 2"
        
        self.selectedLanguage = UserDefaults.standard.string(forKey: "language") ?? "en"
    }
    
    // Function to save setting to storage triggeered when user click back button
    func saveSettings() {
        print(player1Name)
        UserDefaults.standard.set(self.player1Name, forKey: "player1Name")
        
        print(player2Name)
        UserDefaults.standard.set(self.player2Name, forKey: "player2Name")
        
        print(selectedLanguage)
        UserDefaults.standard.set(self.selectedLanguage, forKey: "language")
    }
}
