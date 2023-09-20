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
                            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
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
                            playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
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
                        playSound(sound: "ClickSound", type: "mp3", isRepeat: false)
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
