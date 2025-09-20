//
//  Country.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

struct CountryResponse : Codable {
    
    let countries : [Country]?
    
}

struct Country : Entity, Identifiable, Hashable {
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id
    }
    
    let name : String
    var code : ID
    let currency : String?
    let capital : String?
    let emoji : String?
    let languages : [Language]
    let continent : Continent?
    
    var isFavorited : Bool?
    
    var id : String { code }
}
