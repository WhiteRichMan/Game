//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import SwiftUI

extension Int: Identifiable {
    public var id: Int { self }
}

struct BoardView: View {
    @EnvironmentObject var gameData: GameData
    
    //@AppStorage("isDarkMode") private var isDarkMode: Bool = Theme.darkMode
    
    @State  var showingDetail: Bool = false
    @State  var selectedPropertyIdx: Int? = nil
    
    @State  var dices: [Int] = [1, 1]
    
    @State var showingGoButton: Bool = true
    @State  var showingDices: Bool = false
    
    @State var curPos: Int = 0
    
    @State  var enteredAvailablePropertyIdx: Int? = nil
    @State  var buyingOption: Int = 0
    
    @State  var displayingEndturn: Bool = false
    @State  var displayOptionBar: Bool = false
    
    @State  var enteredOwnedPropertyIdx: Int? = nil
    
    @State var isBankrupt: Bool = false
    @State var isGameOver: Bool = false
    
    @State private var isBuildingMode: Bool = false
    
    // Bind presentation mode of DetailView to  the PokeListView and will be used by the custom back button to dismiss the view.
    @Binding var backMenu: Bool
    
    // Custom back button
    var backButton : some View {
        Button(action: {
            // Dismiss to go back to main menu
            backMenu = true
        })  {
            Circle()
                .fill(LinearColorConstant.linearBlack)
                .frame(height:  UIDevice.isIPad ? 55 : 40)
                .overlay(alignment: .center, content: {
                    Image(systemName: "arrowshape.backward.fill")
                        .foregroundColor(.white)
                        .font(.system(size:  UIDevice.isIPad ? 34 : 24, weight: .medium))
                    
                })
                .foregroundColor(.black)
                .shadow(color: Color("BlackTransparent"), radius: 7)
        }
        .contentShape(Circle())
        .padding(.top)
        .padding(.trailing,  UIDevice.isIPad ? 50 : 20)
        
    }
    
    var body: some View {
        // MARK: ZStack for background
        ZStack {
           
            // MARK: Main Gameplay
            HStack {
                // MARK: Buttons bar at the right of screen
                VStack {
                    Button(action: {
                        self.showingGoButton = false
                        showingDices.toggle()
                    }, label: {
                        Image("GoButton")
                            .resizable()
                            .scaledToFit()
                            .frame(height: UIScreen.main.bounds.width*0.1)
                            .overlay(alignment: .center, content: {
                                
                                Text("Go")
                                    .font(.system(size: 24, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            })
                            .modifier(Shadown3DModifier())
                    })
                    .disabled(!showingGoButton)
                    .opacity(showingGoButton ? 1.0 : 0.0)
                    .padding(.top, UIDevice.isIPad ? 150 : 60)
                    
                    
                    Spacer()
                    
                    // MARK: Button to add house
                    Button(action: {
                        isBuildingMode.toggle()
                        displayingEndturn.toggle()
                    }, label: {
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
                    })
                    .disabled(!displayOptionBar)
                    .opacity(displayOptionBar ? 1.0 : 0.0)
                    .modifier(Shadown3DModifier())
                    
                    Spacer()
                    
                    // MARK: Endturn button
                    Capsule()
                        .fill(Color("red"))
                        .frame(width: UIScreen.main.bounds.height*(UIDevice.isIPad ? 0.30 : 0.38), height: UIScreen.main.bounds.width*0.06)
                        .overlay {
                            Button(action: {
                                endTurn()
                                
                                self.gameData.saveData()
                            }, label: {
                                Text("END TURN")
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 23, weight: .bold))
                                    .foregroundColor(.white)
                            })
                        }
                        .padding(.leading)
                        .disabled(!displayingEndturn)
                        .opacity(displayingEndturn ? 1.0 : 0.0)
                        .padding(.bottom, UIDevice.isIPad ? 100 : 40)
                        .scaleEffect( UIDevice.isIPad ? 0.7 : 1)
                        .modifier(Shadown3DModifier())
                } // end VStack Buttons bar at the right of screen
                .padding(.leading, UIDevice.isIPad ? 50 : -20)
                
                
                // MARK: Board View
                VStack(spacing: 0) {
                    // MARK: Top Row
                    HStack(spacing: 0) {
                        CornerView(imageName: "freeParkingCorner", rotateDegree: 180, padding: 2, position: 20)
                        
                        ForEach(18...26, id:\.self) {idx in
                            Button(action: {
                                if (isBuildingMode
                                        && gameData.propertyList[idx].type == "street"
                                        && gameData.playerList[gameData.currentTurn].properties.contains(where: {p in p.name == gameData.propertyList[idx].name })
                                        && gameData.playerList[gameData.currentTurn].money > Int(gameData.propertyList[idx].house_price)!) {
                                    
                                    self.gameData.buyHouse(property: gameData.propertyList[idx])
                                }
                                else if (!isBuildingMode){
                                    self.selectedPropertyIdx = idx
                                    showingDetail.toggle()
                                }
                            }, label: {
                                VeritalCell(property: gameData.propertyList[idx], isBuildingMode: self.$isBuildingMode)
                                    .rotationEffect(.degrees(180))
                            })
                            .disabled( (gameData.skipSpaces.contains(Int(gameData.propertyList[idx].spaces)!)) )
                        }
                        
                        CornerView(imageName: "freeParkingCorner", rotateDegree: 270, padding: 2, position: 30)
                    } // end HStack Top Row
                    .frame(maxWidth: .infinity)
                    
                    // MARK: Middle Square and 2 vertical rows
                    HStack(spacing: 0) {
                        // MARK: Left side Collumn
                        VStack(spacing: 0) {
                            ForEach( (9...17).reversed(), id:\.self) {idx in
                                Button(action: {
                                    if (isBuildingMode // On building mode
                                            && gameData.propertyList[idx].type == "street"  // this property is street
                                            && gameData.playerList[gameData.currentTurn].properties.contains(where: {p in p.name == gameData.propertyList[idx].name }) // current player have this property
                                            && gameData.playerList[gameData.currentTurn].money > Int(gameData.propertyList[idx].house_price)! // current play have enough money
                                    ) {
                                        
                                        self.gameData.buyHouse(property: gameData.propertyList[idx])
                                    }
                                    else if (!isBuildingMode){
                                        self.selectedPropertyIdx = idx
                                        showingDetail.toggle()
                                    }
                                }, label: {
                                    HorizontalCell(property: gameData.propertyList[idx], isBuildingMode: self.$isBuildingMode)
                                })
                                .disabled( (gameData.skipSpaces.contains(Int(gameData.propertyList[idx].spaces)!)) )
                            }
                        } // end VStack Left side Collumn
                        
                        CenterSquareView()
                        
                        // MARK: Right side collumn
                        VStack(spacing: 0) {
                            ForEach(27...35, id:\.self) {idx in
                                Button(action: {
                                    if (isBuildingMode
                                            && gameData.propertyList[idx].type == "street"
                                            && gameData.playerList[gameData.currentTurn].properties.contains(where: {p in p.name == gameData.propertyList[idx].name })
                                            && gameData.playerList[gameData.currentTurn].money > Int(gameData.propertyList[idx].house_price)!) {
                                        
                                        self.gameData.buyHouse(property: gameData.propertyList[idx])
                                    }
                                    else if (!isBuildingMode){
                                        self.selectedPropertyIdx = idx
                                        showingDetail.toggle()
                                    }
                                }, label: {
                                    HorizontalCell(property: gameData.propertyList[idx], isBuildingMode: self.$isBuildingMode)
                                        .rotationEffect(.degrees(180))
                                })
                                .disabled( (gameData.skipSpaces.contains(Int(gameData.propertyList[idx].spaces)!)) )
                            }
                        } // end VStack Left side Collumn
                        
                    } // end HStack Middle Square and 2 vertical rows
                    .frame(maxWidth: .infinity)
                    
                    // MARK: Bottom row
                    HStack(spacing: 0) {
                        CornerView(imageName: "freeParkingCorner", rotateDegree: 90, padding: 2, position: 10)
                        
                        ForEach( (0...8).reversed(), id:\.self) {idx in
                            Button(action: {
                                if (isBuildingMode
                                        && gameData.propertyList[idx].type == "street"
                                        && gameData.playerList[gameData.currentTurn].properties.contains(where: {p in p.name == gameData.propertyList[idx].name })
                                        && gameData.playerList[gameData.currentTurn].money > Int(gameData.propertyList[idx].house_price)!) {
                                    
                                    self.gameData.buyHouse(property: gameData.propertyList[idx])
                                }
                                else if (!isBuildingMode){
                                    self.selectedPropertyIdx = idx
                                    showingDetail.toggle()
                                }
                                
                            }, label: {
                                ZStack {
                                    VeritalCell(property: gameData.propertyList[idx], isBuildingMode: self.$isBuildingMode)
                                }
                            })
                            .disabled( (gameData.skipSpaces.contains(Int(gameData.propertyList[idx].spaces)!)) )
                            
                        }
                        
                        CornerView(imageName: "goCorner", rotateDegree: 0, padding: 0, position: 0)
                    } // end HStack bottom row
                    
                } // end VStack Board View
                .scaleEffect( UIDevice.isIPad ? 0.7 : 0.93)
                .padding(.bottom)
                .offset(x: UIDevice.isIPad ? -120 : -15)
                
                // MARK: Player tabs
                VStack (spacing: 60) {
                    ForEach(0...1, id:\.self) { idx in
                        PlayerTab(playerIdx: idx)
                            .scaleEffect( (idx == self.gameData.currentTurn) ? 1 : 0.85)
                            .modifier(Shadown3DModifier())
                    }
                } // end Players tab
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, UIDevice.isIPad ? 200 : 50)
                .padding(.trailing, UIDevice.isIPad ? 50 : 0)
                .offset(x: UIDevice.isIPad ? -120 : 0)
                
            } // end HStack Main Gameplay
            .padding(.leading, 10)
            
        }// end ZStack for background
        // MARK: Sheet to display detail info when user click on
        .sheet(item: self.$selectedPropertyIdx) {
            DetailView(property: self.gameData.propertyList[$0], dismissButton: true)
                .presentationBackground(.clear)
        }
        // MARK: Sheet to display rolling dices with animations
        .sheet(isPresented: $showingDices) {
            DiceRolling(dices: $dices)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        // MARK: Function to trigger after rolling dice sheet disappear
        .onChange(of: showingDices) { newValue in
            if (!showingDices) {
                // Delay 0.5s
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    check2MoveToken()
                })
                
            }
        }
        // MARK: Display option when player on a property
        .sheet(item: self.$enteredAvailablePropertyIdx, content: {
            PropertyIntroView(buying: $buyingOption, property: self.gameData.propertyList[$0], gameData: self.gameData)
                .scaleEffect( UIDevice.isIPad ? 0.65 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        })
        // MARK: Function to trigger after player choose to buy a property
        .onChange(of: buyingOption) { newValue in
            // If player select Buy
            if (buyingOption == 1) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    buyProperty()
                })
                
            }
            
            if (buyingOption != 0) {
                withAnimation() {
                    displayingEndturn = true
                    displayOptionBar = true
                    buyingOption = 0
                }
            }
        }
        // MARK: Display message when a player entered an owned property
        .sheet(item: self.$enteredOwnedPropertyIdx, content: {
            RentPayView(gameData: self.gameData, property: self.gameData.propertyList[$0], isBankrupt: self.$isBankrupt)
                .scaleEffect( UIDevice.isIPad ? 0.65 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
                .onDisappear{
                    displayingEndturn = true
                    displayOptionBar = true
                }
        })
        // MARK: Display bankrupt announcement
        .sheet(isPresented: $isBankrupt) {
            BankruptView(isGameOver: self.$isGameOver)
                .scaleEffect( UIDevice.isIPad ? 0.65 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        // MARK: Display Congratulation for winner
        .sheet(isPresented: $isGameOver) {
            GameOverView(backMenu: self.$backMenu)
                .scaleEffect( UIDevice.isIPad ? 0.65 : 1)
                .edgesIgnoringSafeArea(.all)
                .presentationBackground(.clear)
        }
        // MARK: Hide default Back Button
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .onAppear {
        }
    }
    
    func check2MoveToken() {
        let total = dices[0] + dices[1]
        
        curPos = gameData.playerList[gameData.currentTurn].curPos + total
        
        // If pass GO
        if (curPos > 39) {
            // IF difficul mode not hard
            if (gameData.difficultyLevel != "Hard") {
                gameData.playerList[gameData.currentTurn].money += 200
            }
            
            curPos -= 40
        }

        // If entered a skip space
        if (gameData.skipSpaces.contains(curPos)) {
            curPos += 1
        }

        // Change position value to move the token
        withAnimation() {
            gameData.playerList[gameData.currentTurn].curPos = curPos
        }
        
        // Delay 0.5s
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            // If user not enter free parking corner
            if ( ![0, 10, 20, 30].contains(curPos) ) {
                let propertyIdx = gameData.propertyList.indices.filter{ gameData.propertyList[$0].spaces == String(curPos) }.first
                
                // Filter for player owned this property
                let owners = gameData.playerList.indices.filter {
                    gameData.playerList[$0].properties.contains(where: {
                        p in p.name == gameData.propertyList[propertyIdx!].name })}
                
                // Check if there is noone owned this property
                if (owners.isEmpty) {
                    // Entered tax office
                    if (gameData.propertyList[propertyIdx!].type == "tax") {
                        self.enteredOwnedPropertyIdx = propertyIdx
                    }
                    
                    // Enterd unowned street
                    else {
                        // Get the index of property that player just move on
                        self.enteredAvailablePropertyIdx = propertyIdx
                    }
                }
                
                // If there is a player own this property
                else if (owners.first! != gameData.currentTurn){
                    self.enteredOwnedPropertyIdx = propertyIdx
                }
                
                // If property own by current player
                else {
                    withAnimation() {
                        displayingEndturn = true
                        displayOptionBar = true
                    }
                }
            }
            
            // If player enter free parking corner
            else {
                
                withAnimation() {
                    displayingEndturn = true
                    displayOptionBar = true
                }
            }
        })
    }
    
    func buyProperty() {
        let propertyIdx = gameData.propertyList.indices.filter{ gameData.propertyList[$0].spaces == String(curPos) }.first!
        
        gameData.playerList[gameData.currentTurn].money -= Int(gameData.propertyList[propertyIdx].cost)!
        
        withAnimation() {
            gameData.playerList[gameData.currentTurn].properties.append(gameData.propertyList[propertyIdx])
        }
        
        // Reset value back to false
        buyingOption = 0
    }
    
    func endTurn() {
        withAnimation() {
            displayingEndturn = false
            displayOptionBar = false
            
            self.gameData.currentTurn = self.gameData.currentTurn > 0 ? 0 : 1
            
            print(self.gameData.currentTurn)
            self.showingGoButton = true
        }
        
    }
}
