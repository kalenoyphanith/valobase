//
//  WeaponsStruct.swift
//  Valobase
//
//  Created by Kalen Oyphanith on 4/19/22.
//

import Foundation


struct WeaponStruct: Identifiable, Codable {

    var id: UUID
    var displayName: String
    var displayIcon: String?
    var weaponStats: WeaponStats?
    var shopData: ShopData?
    var skins: [Skins]?

    enum CodingKeys: String, CodingKey {
        case displayName
        case displayIcon
        case weaponStats
        case shopData
        case skins
        case id = "uuid"
    }
    
} // WeaponStruct

struct WeaponStats: Codable {
    var fireRate: Float
    var equipTimeSeconds: Double
    var reloadTimeSeconds: Double
    var damageRanges: [DamageRanges]?
}

struct DamageRanges: Codable{ //nested
    var rangeStartMeters: Int
    var rangeEndMeters: Int
    var headDamage: Float
    var bodyDamage: Float
    var legDamage: Float
}

struct ShopData: Codable {
    var cost: Int
    var category: String
}

struct Skins: Codable, Identifiable{
    
    var displayName: String
    var id: UUID
    //var displayIcon: String
    
    enum CodingKeys: String, CodingKey {
        case displayName
        //case displayIcon
        case id = "uuid"
    }
}

struct WeaponsStruct: Codable{
    var data: [WeaponStruct]
}
