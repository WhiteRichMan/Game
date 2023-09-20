//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct StreetDetailView: View {
    var property: Property
    
    var width: Double
    
    var height: Double
    
    var body: some View {
        VStack(spacing: 5) {
            // MARK: Rectangle stack property name on the header color
            Rectangle()
                .fill(Color(property.color))
                .frame(width: width, height: height*0.22)
                .overlay {
                    Text(property.name.uppercased())
                        .font(.system(size: 12, weight: .bold))
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity, alignment: .center)
                        .foregroundColor(property.color == "darkblue" ? .white : .black)
                }
                .border(.black, width: 1)
            
            VStack {
                // MARK: Purchase Cost
                CostLine(text: "Purchase Cost", value: property.cost)
                    .font(.system(size: 11, weight: .none))
                
                // MARK: Mortgage Cost
                CostLine(text: "Mortgage Value", value: String(Int(property.cost)!/2))
                    .font(.system(size: 11, weight: .none))
            }
            
            Divider()
                .overlay(.black)
            
            // MARK: Rent Cost
            VStack {
                // MARK: Rent Cost
                CostLine(text: "Rent", value: property.rent_0)
                    .font(.system(size: 9, weight: .medium, design: Font.Design.rounded))
                    .padding(.bottom, 2)
                
                // MARK: Rent with color set Cost
                CostLine(text: "Rent with color set", value: String(Int(property.rent_0)!*2))
                    .font(.system(size: 9, weight: .medium))
                
                // MARK: Rent 1 Cost
                RentLine(title: "Rent with", houseNumber: 1, value: property.rent_1)
                    .font(.system(size: 9, weight: .medium))
                
                // MARK: Rent 2 Cost
                RentLine(title: "Rent with", houseNumber: 2, value: property.rent_2) // end HStack Rent Cost
                    .font(.system(size: 9, weight: .medium))
                
                // MARK: Rent 3 Cost
                RentLine(title: "Rent with", houseNumber: 3, value: property.rent_3) // end HStack Rent Cost
                    .font(.system(size: 9, weight: .medium))
                
                // MARK: Rent 4 Cost
                RentLine(title: "Rent with", houseNumber: 4, value: property.rent_4) // end HStack Rent Cost
                    .font(.system(size: 9, weight: .medium))
                
                // MARK: Rent with hotel
                HStack {
                    Text("Rent with")
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Image("hotelIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14)
                        .opacity(0.7)
                    
                    Spacer()
                    
                    Text("$\(String(format: "%-4d", Int(property.rent_hotel)!))")
                        .fontDesign(.monospaced)
                } // end Rent with hotel
                .font(.system(size: 9, weight: .medium))
            } // end VStack Rent Cost
            
            Divider()
                .overlay(.black)
            
            // MARK: Building cost
            VStack {
                // MARK: House price
                HStack(spacing: 0) {
                    BuildingPriceLine(imageName: "houseIcon", title: "House cost", value: property.house_price)
                }
                .font(.system(size: 9, weight: .none))
                
                // MARK: Hotel price
                HStack(spacing: 0) {
                    BuildingPriceLine(imageName: "hotelIcon", title: "Hotel cost", value: "\(property.house_price)(+")
                    
                    ZStack {
                        Image("houseIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .opacity(0.7)
                        
                        Text("3")
                            .font(.system(size: 7, weight: .bold))
                            .foregroundColor(.white)
                    }
                    
                    Text(")")
                }
                .font(.system(size: 9, weight: .none))
            } // end VStack Building cost
        }
    }
}


