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

struct VeritalCell: View {
    var property: Property
    
    @EnvironmentObject var gameData: GameData
    
    @Binding var isBuildingMode: Bool
    
    // Define height and width based on the screen size
    private var height: CGFloat {
        return  UIScreen.main.bounds.height*0.132
    }
    
    private var width: CGFloat {
        return height*0.618
    }
    
    private var textColor: Color {
        return .black
    }
    
    private var isOwnedByCurrentPlayer: Bool {
        return gameData.playerList[gameData.currentTurn].properties.contains(where: {p in p.name == property.name })
    }
    
    var body: some View {
        // MARK: Most outer white rectangle
        Rectangle()
            .fill(Color(red: 0.80, green: 0.92, blue: 0.8))
            .frame(width: width, height: height)
            .overlay{
                ZStack {
                    // MARK: Street property
                    if (property.type == "street") {
                        // MARK: VStack street property
                        VStack(spacing: 0) {
                            Rectangle()
                                .fill(Color(property.color))
                                .frame(width: width, height: height*0.26)
                                .frame(maxHeight: .infinity, alignment: .top)
                                // MARK: Display houses
                                .overlay(alignment: .center, content: {
                                    HStack(spacing: 0) {
                                        // Iterate through each player in list
                                        ForEach(0...1, id: \.self) {id in
                                            // If the player have this property
                                            if (gameData.playerList[id].properties.contains(where: {p in p.name == property.name })) {
                                                // Get the index of property
                                                let propertyIdx = gameData.playerList[id].properties.indices.filter{gameData.playerList[id].properties[$0].name == property.name}.first
                                                
                                                let numHouse = (gameData.playerList[id].properties[propertyIdx!].num_house ?? 0);
                                                
                                                // There is Hotel
                                                if (numHouse > 4) {
                                                    Image("hotelBuilding")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(height: height*0.26)
                                                }
                                                // There is house(s)
                                                else {
                                                    ForEach(0..<numHouse, id: \.self) {_ in
                                                        Image("houseBuilding")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: width/4)
                                                    }
                                                }
                                            }
                                        }
                                        
                                    }
                                })
                            
                            // If on building mode AND this property is owned by current player
                            if (isBuildingMode && isOwnedByCurrentPlayer) {
                                // Display price to buy House/Hotel
                                ZStack {
                                    Image("houseIcon")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30)
                                    
                                    Text("$")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white)
                                }
                                
                                Text("\(property.house_price)")
                                    .font(.system(size: 15, weight: .bold))
                                    .foregroundColor(.black)
                                
                                Spacer()
                            } // end  If building mode is on the this property is owned by current player
                            
                            // If not on Building mode
                            // Display normal infomation
                            else {
                                Text(property.name)
                                    .font(.system(size: UIDevice.isIPad ? 14 : 4.3, weight: .medium))
                                    .multilineTextAlignment(.center)
                                    .frame(maxHeight: .infinity, alignment: .top)
                                    .padding(.top, 4)
                                
                                Spacer()
                                
                                Text("$\(property.cost)")
                                    .font(.system(size: UIDevice.isIPad ? 15 : 4, weight: .bold, design: .rounded))
                                    .frame(maxHeight: .infinity, alignment: .bottom)
                                    .padding(.bottom, 5)
                            }
                            
                        } // end VStack street property
                        
                    } // end street property
                    
                    // MARK: Railroad property
                    else if (property.type == "railroad") {
                        VStack(spacing: 0) {
                            Text(property.name)
                                .font(.system(size: 4.5, weight: .medium))
                                .multilineTextAlignment(.center)
                                .frame(maxHeight: .infinity, alignment: .top)
                                .padding(.top, 4)
                            
                            Image("railroad")
                                .resizable()
                                .scaledToFit()
                            
                            Text("$\(property.cost)")
                                .font(.system(size: 4, weight: .heavy))
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                .padding(.bottom, 5)
                        }
                    } // end railroad property
                    
                    
                    // MARK: Skip spaces
                    else if (gameData.skipSpaces.contains(Int(property.spaces)!)) {
                        ZStack {
                            RadialGradient(gradient: Gradient(colors: [Color(red: 0.28, green: 0.33, blue: 0.38), Color(red: 0.16, green: 0.19, blue: 0.23)]), center: .center, startRadius: 15, endRadius: 50)
                            
                            Image("skipIcon")
                                .resizable()
                                .scaledToFit()
                                .rotationEffect(.degrees(180))
                        }
                    } // end Skip spaces
                    
                    // Tax if not a skip space
                    else if (property.type == "tax") {
                        if (property.name == "Luxury Tax") {
                            Image("luxuryTax")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width, height: height)
                        }
                        else if (property.name == "Income Tax") {
                            Image("IncomeTax")
                                .resizable()
                                .scaledToFit()
                                .frame(width: width, height: height)
                                .brightness(0.1)
                        }
                    }
                    
                    // MARK: Player(s) token if there is
                    if (!isBuildingMode) {
                        VStack {
                            ForEach(0..<gameData.playerList.count, id: \.self) { idx in
                                let player = gameData.playerList[idx]
                                
                                if (player.curPos == Int(property.spaces)!) {
                                    player.token
                                        .frame(width: 25)
                                        .brightness( idx == gameData.currentTurn ? 0.2 : -0.1)
                                        .modifier(Shadown3DModifier())
                                }
                            }
                        }
                    }
                    
                    // MARK: Color flag to determine owner
                    ForEach(gameData.playerList) { p in
                        if (p.properties.contains( where: {p in p.name == property.name })) {
                            Rectangle()
                                .fill(p.color)
                                .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                                .frame(width: width-5, height: 10)
                                .offset(y: UIDevice.isIPad ? 70 : 30)
                        }
                    }
                    
                    // MARK: Config Display for Building mode
                    if (isBuildingMode) {
                        // If current player does not own this property
                        if (!isOwnedByCurrentPlayer || property.type != "street") {
                            
                            Color(.black)
                                .frame(width: width, height: height)
                                .opacity(0.5)
                        } // end If current player does not own this property
                    }
                }
            } // end Most outer white rectangle
            .foregroundColor(textColor)
            .border(.black, width: 1)
    }
}
