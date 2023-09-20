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

struct LeaderBoardView: View {
    @Environment(\.dismiss) var dismiss

    var scoreList:  [Record] {
        // Decode the highscore array
        if let objects = UserDefaults.standard.value(forKey: "HighScores") as? Data {
            let decoder = JSONDecoder()

            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Record] {
                return objectsDecoded.sorted(by: {$0.money > $1.money})
            }
            else {
                return [Record]()
            }

        }
        else {
            return [Record]()
        }
    }
    
    var body: some View {
        VStack (spacing: 0) {
            // MARK: VStack Title
            VStack {
                Rectangle()
                    .fill(Color("red"))
                    .frame(width: 500, height: 60)
                    .overlay(alignment: .center, content: {
                        Text("Leader Board")
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
                    ForEach(0..<scoreList.count, id:\.self) {id in
                        let record = scoreList[id]
                        
                        Rectangle()
                            .fill(.white)
                            .cornerRadius(20, corners: [.allCorners])
                            .frame(width: 450, height: (id < 1) ? 80 : 60)
                            .overlay(alignment: .center, content: {
                                HStack {
                                    Image(systemName: "crown.fill")
                                        .font(.system(size: (id < 1) ? 35 : 26, weight: .bold))
                                        .foregroundColor( (id < 1) ? .yellow : (id < 2) ? .gray : Color(red: 0.80, green: 0.50, blue: 0.20) )
                                        .padding(.leading, (id < 1) ? 15 : 20)

                                    Text(record.playerName)
                                        .font(.system(size: (id < 1) ? 22 : 18, weight: .bold, design: .serif))
                                        .padding(.leading, 10)
                                    
                                    Spacer()
                                    
                                    HStack {
                                        Image(systemName: "dollarsign")
                                            .font(.system(size: 24, weight: .heavy))
                                            .foregroundColor(.green)
                                        
                                        
                                        Text("\(record.money)")
                                            .font(.system(size: 20, weight: .bold, design: .serif))
                                            .padding(.trailing, 50)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
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
            print(scoreList)
            
        }
    }
}
