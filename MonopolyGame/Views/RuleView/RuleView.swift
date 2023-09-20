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

struct RuleView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        // MARK: Most outer VStack
        VStack (spacing: 0) {
            // MARK: VStack Title
            VStack {
                Rectangle()
                    .fill(Color("red"))
                    .frame(width: 500, height: 60)
                    .overlay(alignment: .center, content: {
                        Text("MONOPOLY Game Rules")
                            .font(.system(size: 30, weight: .heavy))
                            .foregroundColor(.white)
                    })
            } // end VStack Title
            
            Divider()
                .frame(width: 500, height: 5)
                .background(LinearColorConstant.linearSilver)
            
            ScrollView {
                // MARK: Main VStack
                VStack (spacing: 20) {
                    // MARK: VStack  How to win
                    VStack {
                        Rectangle()
                            .fill(Color("red"))
                            .frame(width: 450, height: 40)
                            .overlay(alignment: .center, content: {
                                Text("How To Win")
                                    .font(.system(size: 25, weight: .heavy))
                                    .foregroundColor(.white)
                            })
                        
                        Text("Move around the board buying as many properties (Streets, Stations and Utilities) as you can. Each player start with $1,500. The more you own, the more rent you'll get. If you're the last player when all other players have gone bankrupt, you win!")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 15, weight: .medium))
                    } // end VStack How to win
                    
                    // MARK: VStack On Your Turn
                    VStack {
                        Rectangle()
                            .fill(Color("red"))
                            .frame(width: 450, height: 40)
                            .overlay(alignment: .center, content: {
                                Text("On Your Turn")
                                    .font(.system(size: 25, weight: .heavy))
                                    .foregroundColor(.white)
                            })
                        
                        StepLine(beforeStr: "", text: "Roll the dices")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        StepLine(beforeStr: "", text: "Your token will move forward that number of spaces")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        StepLine(beforeStr: "", text: "Where did you land?")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        StepLine(beforeStr: "\t", text: "If you land on a Street, you'll have the chance to buy that property (if unowned) or you'll have to pay rent to the owner!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        StepLine(beforeStr: "\t", text: "If you landed on an SKIP SPACE, you'll move forward one space")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        StepLine(beforeStr: "", text: "After moving, you can manage your property, if you want to. You can buy buildings. You can only initiate these actions on your turn.")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack {
                            VStack {
                                Circle()
                                    .fill(.white)
                                    .frame(width: 50, height: 50)
                                    .overlay(alignment: .center, content: {
                                        HStack(spacing: 0) {
                                            Image(systemName: "plus")
                                                .foregroundColor(.red)
                                                .font(.system(size: 15, weight: .heavy))
                                                .padding(.top, 10)
                                            
                                            Image(systemName: "house")
                                                .foregroundColor(.red)
                                                .font(.system(size: 20, weight: .medium))
                                                .padding(.leading, -5)
                                        }
                                    })
                                    .shadow(color: Color("BlackTransparent"), radius: 7)
                                
                                Text("Buy Houses")
                                    .font(.system(size: 12))
                            }
                        }
                        
                        StepLine(beforeStr: "", text: "When you are ready, end your turn.")
                            .frame(maxWidth: .infinity, alignment: .leading)

                    } // end VStack On Your Turn
                    
                    // MARK: VStack Board Spaces
                    VStack (spacing: 20) {
                        // MARK: Street info
                        VStack (spacing: 5) {
                            Rectangle()
                                .fill(Color("red"))
                                .frame(width: 450, height: 40)
                                .overlay(alignment: .center, content: {
                                    Text("Board Spaces")
                                        .font(.system(size: 25, weight: .heavy))
                                        .foregroundColor(.white)
                                })
                            
                            Text("Streets")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18, weight: .bold))
                            
                            Image("StreetSample")
                                .scaledToFit()
                                .frame(height: 120)
                                .shadow(color: Color("BlackTransparent"), radius: 7)
                            
                            Text("Unowned Streets")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18, weight: .bold))
                            
                            Text("When you land on a Street that no one owns, you can buy it or not.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14, weight: .medium))
                            
                            Text("Owned Streets")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18, weight: .bold))
                            
                            Text("When you land on a Street that someone else owns, you must pay them rent!")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14, weight: .medium))
                            
                            StepLine(beforeStr: "\t", text: "If you buy Houses, rent goes up even more!")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            StepLine(beforeStr: "\t", text: "You can also upgrade to Hotels!")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } // end VStack Street info
                        
                        // MARK: Stations
                        VStack (spacing: 5) {
                            Text("Stations")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18, weight: .bold))
                            
                            Image("StationSample")
                                .scaledToFit()
                                .frame(height: 120)
                                .shadow(color: Color("BlackTransparent"), radius: 7)
                            
                            Text("Stations are like Streets, except that Houses and Hotels cannot be built on Stations.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14, weight: .medium))
                            
                            Text("Rent depends on how many Stations the owner has.")
                                .multilineTextAlignment(.center)
                                .font(.system(size: 14, weight: .medium))
                        } // end VStack Stations
                        
                        
                    } // end VStack Board Spaces
                    
                    // MARK: VStack Action Spaces
                    VStack (spacing: 20) {
                        Rectangle()
                            .fill(Color("red"))
                            .frame(width: 450, height: 40)
                            .overlay(alignment: .center, content: {
                                Text("Action Spaces")
                                    .font(.system(size: 25, weight: .heavy))
                                    .foregroundColor(.white)
                            })
                        
                        // MARK: GO Spcace
                        VStack (spacing: 10) {
                            Image("goCorner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100)
                                .shadow(color: Color("BlackTransparent"), radius: 7)
                            
                            Text("If you move took you onto or past the GO space, you get $200 from the Bank")
                                .font(.system(size: 12))
                        } // end VStack GO Spcace
                        
                        // MARK: Free Parking Spcace
                        VStack (spacing: 10) {
                            Rectangle()
                                .fill(Color(red: 0.80, green: 0.92, blue: 0.8))
                                .frame(width: 100, height: 100)
                                .overlay{
                                    Image("freeParkingCorner")
                                        .resizable()
                                        .scaledToFit()
                                }
                                .border(.black, width: 1)
                                .shadow(color: Color("BlackTransparent"), radius: 7)
                            
                            Text("Relax! Nothing happens.")
                                .font(.system(size: 12))
                            
                            Spacer()
                                .frame(height: UIDevice.isIPad ? 175 : 20)
                        } // end VStack Free Parking Spcace
                        
                    } // end VStack Action Spaces
                    
                } // end Main VStack
                .frame(width: 460)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.trailing, UIDevice.isIPad ? 0 : 10)
                .padding(.top, 10)
                
            } // end Scroll View
            .frame(width: 500)
            .background(.white)
            .shadow(color: Color("BlackTransparent"), radius: 7)
            
        } // end most outer VStack
        .padding(.top, UIDevice.isIPad ? 175 : 20)
        .padding(.bottom)
        // MARK: Cancel button
        .overlay(alignment: .topTrailing, content: {
            Circle()
                .fill(.white)
                .frame(width: 40)
                .overlay(
                    Button(action: {
                        dismiss()
                        
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 40, weight: .heavy))
                    })
                    , alignment: .center)
                .foregroundColor(.black)
                .offset(x: UIDevice.isIPad ? -17 : 20, y: UIDevice.isIPad ? 175 : 10)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        })

    }
}
