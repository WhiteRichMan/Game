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
