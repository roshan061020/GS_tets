//
//  Gender.swift
//  GS_Test
//
//  Created by Roshan on 14/06/21.
//
import Foundation

// MARK: - UserElement
struct UserElement: Codable {
    let picture: String
    let name: String
    let geoLocation: GeoLocation
    let gender: Gender
    let age: Int
    let favoriteColor: String
    let phone, lastSeen, id, email: String

    enum CodingKeys: String, CodingKey {
        case picture, name, geoLocation, gender, age, favoriteColor, phone, lastSeen
        case id = "_id"
        case email
    }
}

typealias Users = [UserElement]
