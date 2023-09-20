//
//  MonopolyGameApp.swift
//  MonopolyGame
//
//  Created by Руслан Загидуллин on 24.05.2024.
//


import Foundation

// The list contains all pokemons extracted from json data file Model\pokelist.json
var propertiesList: [Property] = decodeJsonFromJsonFile(jsonFileName: "properties.json")

// Function to decode data from json file
func decodeJsonFromJsonFile(jsonFileName: String) -> [Property] {
    if let file = Bundle.main.url(forResource: jsonFileName, withExtension: nil){
        if let data = try? Data(contentsOf: file) {
            do {
                let decoder = JSONDecoder()
                let decoded = try decoder.decode([Property].self, from: data)
                return decoded
            } catch let error {
                fatalError("Failed to decode JSON: \(error)")
            }
        }
    } else {
        fatalError("Couldn't load \(jsonFileName) file")
    }
    return [ ] as [Property]
}
