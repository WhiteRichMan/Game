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

struct AchievementView: View {
    @Environment(\.dismiss) var dismiss

    var achievementList: [[String]] {
        let initList: [[String]] = [["Win 1 game", "1"], ["Win 3 games", "3"], ["Win 10 games", "10"], ["Win 100 games", "100"]]
        
        var list = UserDefaults.standard.array(forKey: "Achievements") as? [[String]]

        if (list == nil) {
            list = initList

            UserDefaults.standard.set(initList, forKey: "Achievements")
        }
        
        return list!
    }
    
    var numberGamePlayed: Int = UserDefaults.standard.integer(forKey: "numberGamePlayed")
    
    var body: some View {
        VStack (spacing: 0) {
            // MARK: VStack Title
            VStack {
                Rectangle()
                    .fill(Color("red"))
                    .frame(width: 500, height: 60)
                    .overlay(alignment: .center, content: {
                        Text("Achievements")
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundColor(.white)
                    })
            } // end VStack Title
            
            Divider()
                .frame(width: 500, height: 5)
                .background(LinearColorConstant.linearSilver)
            
            // MARK: ZStack to set background for list
            ZStack {
                Color(.white)
                
                // MARK: VSTACK LIST
                VStack (spacing: 20) {
                    ForEach(0..<achievementList.count, id:\.self) {id in
                        let row: [String] = achievementList[id]

                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20, corners: [.allCorners])
                            .frame(width: 450, height: 45)
                            .overlay(alignment: .center, content: {
                                HStack {
                                    Text(LocalizedStringKey(row[0]))
                                        .font(.system(size: 15, weight: .bold, design: .serif))
                                        .padding(.leading, 20)

                                    Spacer()

                                    HStack (spacing : 0) {
                                        Text("\(numberGamePlayed < Int(row[1])! ? numberGamePlayed : Int(row[1])!)/\(row[1])")
                                            .font(.system(size: 15, weight: .bold, design: .serif))
                                    }
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.trailing, 50)
                                    
                                    Spacer()
                                    
                                    Circle()
                                        .fill((id > 2) ? Color(red: 0.73, green: 0.95, blue: 1.00) : (id > 1) ? .yellow : (id > 0) ? .gray : Color(red: 0.80, green: 0.50, blue: 0.20))
                                        .frame(height: 40)
                                        .overlay(alignment: .center, content: {
                                            Image(systemName: "medal.fill")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .heavy))
                                        })
                                        .opacity( numberGamePlayed < Int(row[1])! ? 0 : 1)
                                    
                                    Spacer()
                                }
                            })
                            .modifier(Shadown3DModifier())
                    }

                    Spacer()
                } // end VSTACK LIST
                .padding(.top)
                
            } // end ZStack to set background for list
            .frame(width: 500)
        }
        .padding(.top, UIDevice.isIPad ? 175 : 40)
        .modifier(Shadown3DModifier())
        .overlay(alignment: .topTrailing, content: {
            Circle()
                .fill(.white)
                .frame(width: 40)
                .overlay(alignment: .center, content: {
                    Button(action: {
                        dismiss()

                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40, weight: .heavy))
                    })
                })
                .foregroundColor(.black)
                .offset(x: UIDevice.isIPad ? -17 : 20, y: UIDevice.isIPad ? 175 : 10)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        })
        .onAppear {
            print(achievementList)
        }
    }
}

struct AchievementView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
