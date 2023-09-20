//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct RentPayView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var gameData: GameData
    
    var property: Property
    
    private var ownerIdx: Int {
        // Entered tax office
        if (property.type == "tax") {
            return 0
        }
        
        return gameData.playerList.indices.filter{ gameData.playerList[$0].properties.contains(where: {p in p.name == property.name}) }.first!
    }
    
    // Calculate rentFee
    private var rentFee: String {
        // Entered tax office
        if (property.type == "tax") {
            return property.cost
        }
        
        // Else entered owned property
        let propertyIdx = gameData.playerList[ownerIdx].properties.indices.filter{ gameData.playerList[ownerIdx].properties[$0].name == property.name }.first!
        var fee = property.rent_0
        
        // If Streen property
        if (property.type == "street") {
            switch (gameData.playerList[ownerIdx].properties[propertyIdx].num_house) {
            case 1: fee = property.rent_1
                
            case 2: fee = property.rent_2
                
            case 3: fee = property.rent_3
                
            case 4: fee = property.rent_4
                
            case 5: fee = property.rent_hotel
                
            default: fee = property.rent_0
            }
        }
        // IF railroad property
        else if (property.type == "railroad") {
            // Count number of railroad owner has
            var count = 0
            
            for p in gameData.playerList[ownerIdx].properties {
                if p.type == "railroad" {
                    count += 1
                }
            }
            
            switch (count) {
            case 2: return String(Int(property.rent_0)!*2)
                
            case 3: return String(Int(property.rent_0)!*4)
                
            case 4: return String(Int(property.rent_0)!*8)
                
            default: return property.rent_0
            }
        }
        
        return fee
    }
    
    @Binding var isBankrupt: Bool
    
    var body: some View {
        VStack (spacing: 10) {
            // MARK: Property detail and decor view
            HStack {
                DetailView(property: property, dismissButton: false)
                    .scaleEffect(0.9)
                    .rotationEffect(.degrees(-5))
                    .rotationEffect(.degrees(-5))
                    .padding(.leading, 20)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                
                Spacer()
                
                // MARK: Decor view
                ZStack {
                    //MARK: Price
                    ZStack {
                        Image(systemName: "bubble.right.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundColor(.white)
                        
                        // MARK: Messge text
                        Text("\(gameData.playerList[gameData.currentTurn].name) \npaid $\(rentFee) to \n \( (property.type == "tax") ? "Bank" : gameData.playerList[ownerIdx].name)")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15, weight: .bold))
                            .padding(.bottom)
                    } // end ZStack Price
                    .frame(maxHeight: .infinity, alignment: .top)
                    .offset(x: -60, y: 60)
                    
                    Image("RentDue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.height*0.45)
                        .offset(y: 70)
                        .padding(.trailing)
                } // end ZStack Decor view
                .frame(maxHeight: .infinity)
            } // end 1st HStackProperty detail and decor view
            .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width*0.4)
            
        } // end 1st VStack
        .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width*0.5)
        .padding(.bottom, 20)

        // Tap on Screen to close view
        .onTapGesture {
            isBankrupt = gameData.payRent(property: property, ownerIdx: ownerIdx)
            

            
            dismiss()
        }
    }
}
