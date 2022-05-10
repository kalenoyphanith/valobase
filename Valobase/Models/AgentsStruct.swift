//
//  AgentsStruct.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/19/22.
//

import Foundation

struct AgentStruct: Identifiable, Codable {
    
    var id: UUID
    var displayName: String
    var description: String
    var displayIcon: String?
    var role: Role?
    var abilities: [Abilities]?
    var fullPortraitV2: String?
    var bustPortrait: String?
    
    enum CodingKeys: String, CodingKey {
        case displayName
        case description
        case displayIcon
        case role
        case abilities
        case id = "uuid"
        case fullPortraitV2
        case bustPortrait
    }
    
} // AgentStruct

struct Role: Codable { // nested
    var displayName: String
    var description: String
}

struct Abilities: Codable {
    var slot: String
    var displayName: String
    var description: String
    var displayIcon: String?
}

struct AgentsStruct: Codable{
    var data: [AgentStruct]
}
