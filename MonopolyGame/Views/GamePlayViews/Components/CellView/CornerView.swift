/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Thieu Tran Tri Thuc
  ID: s3870730
  Created  date: 15/8/2023
  Last modified: 5/8/2023
  Acknowledgement:
    - The UI components is inspired from:
        Isaac, “Monopoly: Figma community,” Figma, https://www.figma.com/community/file/1223059141348879689/MONOPOLY (accessed Aug. 15, 2023).
    - The UI designs are inspired from:
        This popular Hasbro board game is enjoyed by over a billion people worldwide, We are confident the entire family will fall in love with game night, and MONOPOLY now includes multiplayer video chat. Create a free, “Monopoly - the classic board game on mobile by Marmalade Game Studio,” Marmalade Game Studio, https://www.marmaladegamestudio.com/games/monopoly/ (accessed Aug. 15, 2023).
 */

import SwiftUI

struct CornerView: View {
    var imageName: String
    
    var rotateDegree: Double
    
    var padding: Double
    
    @EnvironmentObject var gameData: GameData
    
    var position: Int
    
    private var len: CGFloat {
        return UIScreen.main.bounds.height*0.132
    }
    
    var body: some View {
        Rectangle()
            .fill(Color(red: 0.80, green: 0.92, blue: 0.8))
            .frame(width: len, height: len)
            .overlay{
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(rotateDegree))
                    .padding(padding)
            }
            .border(.black, width: 1)
            .overlay(
                VStack {
                    ForEach(gameData.playerList) { p in
                        if (p.curPos == position) {
                            p.token
                                .frame(width: 25)
                        }
                    }
                }
                     ,alignment: .center)
    }
}
