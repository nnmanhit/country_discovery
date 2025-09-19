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
    static let OPENAI_API_KEY = "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"
    
    static let GEMINI_API_KEY = "AIzaSyCz8ai7-z4Ca0qxqUVT9TjGGz17f-VfCr8"
    
    static let realmConfiguration = Realm.Configuration(
        schemaVersion: 4,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                // do nothing for now; Realm will handle new properties with default values
            }
        }
    )
    
}
