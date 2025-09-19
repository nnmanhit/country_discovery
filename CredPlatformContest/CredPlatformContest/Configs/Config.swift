//
//  Config.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import RealmSwift
import Foundation

struct Config {
    
    static let env : Env = .Prod
    static let lang : String = "en"
    
    // Temporary set it on config. These keys should be fetched from the backend for security.
    static let OPENAI_API_KEY = ProcessInfo.processInfo.environment["OPENAI_API_KEY"]
    
    static let GEMINI_API_KEY = ProcessInfo.processInfo.environment["GEMINI_API_KEY"]
    
    static let realmConfiguration = Realm.Configuration(
        schemaVersion: 4,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                // do nothing for now; Realm will handle new properties with default values
            }
        }
    )
    
}
