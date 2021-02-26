//
//  Pokedex.swift
//  pokedex
//
//  Created by APPMAN M-021 on 7/2/2564 BE.
//

import Foundation

struct Pokedex: Codable {
    var cards: [Cards]
    
}

struct Cards: Codable {
    let id: String
    let name: String
    var isSelected: Bool
    let imageUrl: String
    let hp: Int
    let rarity: Int
    let attacks: [Attack]
    let weaknesses: [Weakness]

}

struct Attack: Codable {
    let name: String
    let damage: String

}

struct Weakness: Codable {
    let type: String
    let value: String
}
