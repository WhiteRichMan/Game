//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import Foundation
import SwiftUI

struct Property: Codable, Equatable {
    let name: String
    let type: String
    let color, spaces, cost, house_price: String
    let rent_0, rent_1, rent_2, rent_3, rent_4: String
    let rent_hotel: String
    
    var num_house: Int? = 0
    
    public static func == (lhs: Property, rhs: Property) -> Bool{
            return
        lhs.name == rhs.name &&
        lhs.type == rhs.type &&
        lhs.color == rhs.color &&
        lhs.spaces == rhs.spaces &&
        lhs.cost == rhs.cost &&
        lhs.house_price == rhs.house_price &&
        lhs.rent_0 == rhs.rent_0 &&
        lhs.rent_1 == rhs.rent_1 &&
        lhs.rent_2 == rhs.rent_2 &&
        lhs.rent_3 == rhs.rent_3 &&
        lhs.rent_4 == rhs.rent_4 &&
        lhs.num_house == rhs.num_house
    }
}
