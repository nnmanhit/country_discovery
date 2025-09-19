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
