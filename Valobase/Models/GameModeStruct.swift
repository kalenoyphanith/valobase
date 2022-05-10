//
//  GameModeStruct.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 5/1/22.
//

import Foundation

struct GameModeStruct: Identifiable, Codable {
    
    var id: UUID
    var displayName: String
    var duration: String?
    var displayIcon: String?

    
    enum CodingKeys: String, CodingKey {
        case displayName
        case duration
        case displayIcon
        case id = "uuid"

    }
} //GameModeStruct

struct GameModesStruct: Codable{//Codable
    var data: [GameModeStruct]
}
