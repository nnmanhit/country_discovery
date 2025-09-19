//
//  ContinentRealm.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/19/25.
//

import RealmSwift

class ContinentRealm : Object {
    
    @Persisted(primaryKey: true) var code : ID
    @Persisted var name : String
    
}

extension ContinentRealm {
    
    func toEntity() -> Continent {
        return Continent(code: self.code, name: self.name)
    }
    
}
