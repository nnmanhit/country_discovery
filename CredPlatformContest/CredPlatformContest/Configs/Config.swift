//
//  Config.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import Foundation

struct Config {
    
    static let env : Env = .Prod
    static let lang : String = "en"
    
    // Temporary set it on config. These keys should be fetched from the backend for security.
    static let OAK = openBagToFindEgg()
    
    static let GAK = openEggToFindBag()
    
}
