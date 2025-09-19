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

extension Country {
    
    func toRealm() -> CountryRealm {
        
        let realm = CountryRealm()
        realm.name = self.name
        realm.capital = self.capital
        realm.emoji = self.emoji
        realm.code = self.code
        realm.currency = self.currency
        realm.isFavorited = self.isFavorited
        realm.continent = self.continent?.toRealm()
        return realm
        
    }
    
}
