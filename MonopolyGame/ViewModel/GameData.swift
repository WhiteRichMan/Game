//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//

import Foundation
import SwiftUI

class GameData: ObservableObject, Codable {
    // Default value
    @Published var propertyList: [Property]
    
    @Published var playerList: [Player]
    
    @Published var currentTurn: Int
    
    private var mode: String = ""
    
    var difficultyLevel: String = "Easy"
    
    var skipSpaces: [Int]
    
    // Initializer with default values above
    init(mode: String) {
        self.mode = mode
        
        let player1Name: String = UserDefaults.standard.string(forKey: "player1Name") ?? "Player 1"
        let player2Name: String = UserDefaults.standard.string(forKey: "player2Name") ?? "Player 2"
        
        self.playerList = [Player(id: 1, name: player1Name, money: 1500, curPos: 0, tokenName: "tokenDuck", colorName: "blue"),
                                           Player(id: 2, name: player2Name, money: 1500, curPos: 0, tokenName: "tokenPenguin", colorName: "orange")]
        
        self.currentTurn = 0
            
        self.propertyList = propertiesList
        
        self.difficultyLevel = UserDefaults.standard.string(forKey: "DifficultyLevel") ?? "Easy"
        
        if (difficultyLevel == "Easy") {
            self.skipSpaces = propertiesList.filter({ ["chance", "utility", "tax"].contains($0.type)}).map({ Int($0.spaces)!})
        }
        else {
            self.skipSpaces = propertiesList.filter({ ["chance", "utility"].contains($0.type)}).map({ Int($0.spaces)!})
        }
        
        //Initilize house_num value for raw data decode from json file
        for id in 0..<self.propertyList.count {
            self.propertyList[id].num_house = 0
        }
    }
    
    func buyHouse(property: Property) {
        let propertyIdx = playerList[currentTurn].properties.indices.filter{ playerList[currentTurn].properties[$0].name == property.name }.first!
        
        if (playerList[currentTurn].properties[propertyIdx].num_house! < 5) {
            playerList[currentTurn].properties[propertyIdx].num_house! += 1
            
            playerList[currentTurn].money -= Int(property.house_price)!
            
        }
    }
    
    func payRent(property: Property, ownerIdx: Int) -> Bool {
        var rentFee = 0
        
        // Entered tax office
        if (property.type == "tax") {
            rentFee = Int(property.cost)!
        }
        // Entered owned street
        else {
            let propertyIdx = playerList[ownerIdx].properties.indices.filter{ playerList[ownerIdx].properties[$0].name == property.name }.first!
            
            if (property.type == "street") {
                switch (playerList[ownerIdx].properties[propertyIdx].num_house!) {
                case 1: rentFee = Int(property.rent_1)!
                    
                case 2: rentFee = Int(property.rent_2)!
                    
                case 3: rentFee = Int(property.rent_3)!
                    
                case 4: rentFee = Int(property.rent_4)!
                    
                case 5: rentFee = Int(property.rent_hotel)!
                    
                default: rentFee = Int(property.rent_0)!
                }
            }
            
            else if (property.type == "railroad") {
                // Count number of railroad owner has
                var count = 0
                
                for p in playerList[ownerIdx].properties {
                    if p.type == "railroad" {
                        count += 1
                    }
                }
                
                switch (count) {
                case 2: rentFee = Int(property.rent_0)!*2
                    
                case 3: rentFee = Int(property.rent_0)!*4
                    
                case 4: rentFee = Int(property.rent_0)!*8
                    
                default: rentFee = Int(property.rent_0)!
                }
            }
            
            self.playerList[ownerIdx].money += rentFee
        }
        
        self.playerList[currentTurn].money -= rentFee
        
        if (self.playerList[currentTurn].money < 0) {
            processHighScore()
            
            clearData()
            
            return true
        }
        
        return false
    }
    
    // Function to load current game data from AppStorage with key "gameData"
    func loadData (isNewGame: Bool, mode: String) {
        self.mode = mode
        
        if (!isNewGame) {
            // Load game data
            if let data = UserDefaults.standard.data(forKey: mode) {
                do {
                    // Create decoder
                    let decoder = JSONDecoder()

                    print("Loaded Data")
                    let gameData =  try decoder.decode(GameData.self, from: data)
                    
                    self.playerList = gameData.playerList
                    self.currentTurn = gameData.currentTurn
                    self.propertyList = gameData.propertyList
                    self.difficultyLevel = gameData.difficultyLevel
                    self.skipSpaces = gameData.skipSpaces
                    
                    return
                }
                catch {
                    print("Unable to Decode Game Data (\(error)")
                }
            }
            
            return
        }
        print("New Game")
        
        clearData()
    }
    
    // Function to save current game data to AppStorage with key "gameData"
    func saveData() {
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()

            // Encode Note
            let data = try encoder.encode(self)

            // Write/Set Data
            print("Save: \(self.currentTurn)")
            UserDefaults.standard.set(data, forKey: mode)

        } catch {
            print("Unable to Encode Game Data (\(error))")
        }
    }
    
    func getAllRecords() -> [Record] {
        if let objects = UserDefaults.standard.value(forKey: "HighScores") as? Data {
            print(objects)
            let decoder = JSONDecoder()
            
            if let objectsDecoded = try? decoder.decode(Array.self, from: objects) as [Record] {
                return objectsDecoded.sorted(by: {$0.money > $1.money})
            }
            else {
                return [Record]()
            }
            
        }
        else {
            return [Record]()
        }
    }
    
    func processHighScore() {
        let winner = self.playerList[currentTurn == 0 ? 1:0]
        
        let newRecord = Record(playerName: winner.name, money: winner.money)
        
        var recordArr = getAllRecords()
        
        // Add new record to array
        recordArr.append(newRecord)
        
        // If array longer than 3
        if (recordArr.count > 3) {
            // Sort the array
            recordArr = recordArr.sorted(by: {$0.money > $1.money})
            
            // Remove the last record (the minimum one)
            recordArr.remove(at: 3)
        }
        
        // Encode and save
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(recordArr){
            UserDefaults.standard.set(encoded, forKey: "HighScores")
        }
        
        // MARK: Process number of of won games to update achievements
        var numberGamePlayed = UserDefaults.standard.integer(forKey: "numberGamePlayed") 
        
        numberGamePlayed += 1
        
        UserDefaults.standard.setValue(numberGamePlayed, forKey: "numberGamePlayed")
    }
    
    func clearData() {
        UserDefaults.standard.removeObject(forKey: mode)
    }

    // Below is functions for decoding and encoding purposes
    enum CodingKeys: CodingKey {
        case playerList, currentTurn, propertyList, difficultyLevel, skipSpaces
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(playerList, forKey: .playerList)
        try container.encode(currentTurn, forKey: .currentTurn)
        try container.encode(propertyList, forKey: .propertyList)
        try container.encode(difficultyLevel, forKey: .difficultyLevel)
        try container.encode(skipSpaces, forKey: .skipSpaces)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        playerList = try container.decode([Player].self, forKey: .playerList)
        currentTurn = try container.decode(Int.self, forKey: .currentTurn)
        propertyList = try container.decode([Property].self, forKey: .propertyList)
        difficultyLevel = try container.decode(String.self, forKey: .difficultyLevel)
        skipSpaces = try container.decode([Int].self, forKey: .skipSpaces)
    }
}
