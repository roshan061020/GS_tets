//
//  Gender.swift
//  GS_Test
//
//  Created by Roshan on 14/06/21.
//
enum Gender: String, Codable,CaseIterable {
    case female = "female"
    case male = "male"
    
    static var getAllCases: [String]{
        Gender.allCases.map{$0.rawValue.capitalized}
    }
    
    func toString()->String{
        self.rawValue.capitalized
    }
    
}
