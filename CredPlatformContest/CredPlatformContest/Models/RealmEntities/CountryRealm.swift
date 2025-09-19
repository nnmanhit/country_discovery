//
//  Country.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import RealmSwift

import Foundation

class CountryRealm : Object {
    
    @Persisted(primaryKey: true) var code : ID
    @Persisted var name : String
    @Persisted var currency : String?
    @Persisted var capital : String?
    @Persisted var isFavorited : Bool?
    
}

extension CountryRealm {
    
    func toEntity() -> Country {
        return Country(name: name, code: code, currency: currency, capital: capital, languages: [], isFavorited: isFavorited ?? false)
    }
    
}
