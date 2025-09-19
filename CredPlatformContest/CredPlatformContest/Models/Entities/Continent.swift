//
//  Continent.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

struct Continent : Entity, Codable, Hashable {
    
    var code: ID
    let name : String
    
}

extension Continent {
    
    func toRealm() -> ContinentRealm {
        let realm = ContinentRealm()
        realm.name = self.name
        realm.code = self.code
        return realm
    }
    
}
