//
//  Country.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

struct CountryResponse : Codable {
    
    let countries : [Country]?
    
}

struct Country : Entity, Identifiable {
    
    let name : String
    var code : ID
    let currency : String?
    let capital : String?
    let languages : [Language]
    
    var id : String { code }
}
