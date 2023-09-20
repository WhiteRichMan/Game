//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

struct RailRoadDetailView: View {
    var property: Property
    
    var width: Double
    
    var height: Double
    
    var body: some View {
        // MARK: Most outer VStack
        VStack (spacing: 10) {
            // MARK: Station image
            Image("railroad")
                .resizable()
                .scaledToFit()
                .frame(width: width*0.6)
                .padding()
            
            // MARK: Name
            Text(property.name.uppercased())
                .font(.system(size: 12, weight: .bold))
                .multilineTextAlignment(.center)
            
            // MARK: Cost
            VStack (spacing: 5) {
                // MARK: Purchase Cost
                CostLine(text: "Purchase Cost", value: property.cost)
                    .font(.system(size: 9, weight: .medium))
                
                // MARK: Mortgage Cost
                CostLine(text: "Mortgage Value", value: String(Int(property.cost)!/2))
                    .font(.system(size: 9, weight: .medium))
            }
            
            Divider()
                .overlay(.black)
            
            // MARK: Rent Cost
            VStack (spacing: 5) {
                // MARK: Rent Cost
                CostLine(text: "Rent", value: property.rent_0)
                    .font(.system(size: 8, weight: .medium))
                    .padding(.bottom, 2)
                
                // MARK: Rent with color set Cost
                CostLine(text: "Rent with 2 stations are owned", value: String(Int(property.rent_0)!*2))
                
                // MARK: Rent with color set Cost
                CostLine(text: "Rent with 3 stations are owned", value: String(Int(property.rent_0)!*4))
                
                // MARK: Rent with color set Cost
                CostLine(text: "Rent with 4 stations are owned", value: String(Int(property.rent_0)!*8))
            } // end VStack Rent Cost
            .font(.system(size: 7, weight: .medium))
            
        } // end Most outer VStack
    }
}
