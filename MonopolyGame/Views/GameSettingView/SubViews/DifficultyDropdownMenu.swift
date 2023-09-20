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

struct DifficultyDropdownMenu: View {
    // Default difficul levels
    private let difficultyLevels: [String] = ["Easy", "Medium", "Hard"]
    
    @State var selectedLevel: String = UserDefaults.standard.string(forKey: "DifficultyLevel") ?? "Easy"
    
    var body: some View {
        HStack (spacing: UIDevice.isIPad ? 40 : 20) {
            // MARK: Drop Down Menu
            Menu {
               // Iterate through all type to display all options
               ForEach(difficultyLevels, id: \.self) { option in
                   // Each option is displayed as button
                   Button(action: {// When the button is clicked
                       // Change the selectedOption to let the dropdownMenu update the background color
                       selectedLevel = option
                       
                       UserDefaults.standard.set(selectedLevel, forKey: "DifficultyLevel")
                   }
                   ) {
                       // Display type as label of button
                       Text(LocalizedStringKey(option))
                   }
               }
           }label: { // The label of Menu
               // Display horizontally
               HStack {
                   // Display current selected option
                   Text(LocalizedStringKey(selectedLevel))
                       .frame(maxWidth: .infinity, alignment: .center)
                   
                   Spacer()
                   
                   // An decoration arrow
                   Text("⌵")
                       .offset(y: -4)
                       .padding(.trailing, 15)
               }
               // Change text color based on the selected type (element)
               .foregroundColor(.black)
               .font(.system(size: 18, weight: .bold))
               .frame(width: 150, height: 42)
               // Change background color based on the selected type (element)
               .background(.white)
               // Rounded the corners
               .cornerRadius(49)
           } // end Drop Down Menu
           .padding(.horizontal)
           .scaleEffect(UIDevice.isIPad ? 2 : 1)
            
            // MARK: Detail text
            Group {
                if (selectedLevel == "Easy") {
                    Text("Get 200$ salary when passing GO. No taxes.")
                }
                else if (selectedLevel == "Medium") {
                    Text("Get 200$ salary when passing GO. 2 Tax offices")
                }
                else if (selectedLevel == "Hard") {
                    Text("No salary when passing GO. 2 Tax offices")
                }
            } // end Detail text
            .frame(width: UIScreen.main.bounds.width*0.5)
            .scaleEffect(UIDevice.isIPad ? 1.8 : 1)
        }
    }
}

