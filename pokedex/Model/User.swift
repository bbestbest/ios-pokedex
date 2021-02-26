//
//  User.swift
//  pokedex
//
//  Created by APPMAN M-021 on 7/2/2564 BE.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let geo: GEO
}

struct GEO: Codable {
    let lat: String
    let long: String

    private enum CodingKeys: String, CodingKey {
        case lat, long = "lng"
    }
}
