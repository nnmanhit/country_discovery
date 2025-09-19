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
        schemaVersion: 5,
        migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                // do nothing for now; Realm will handle new properties with default values
            }
        }
    )
    
}
