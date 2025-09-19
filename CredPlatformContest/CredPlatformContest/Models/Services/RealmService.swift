//
//  RealmService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import RealmSwift

class RealmService : StorageServiceProtocol {
    
    var realm : Realm
    
    init() {
        self.realm = try! Realm(configuration: Config.realmConfiguration)
    }
    
    func insertCountries(countries: [Country]) async throws {
        try await Task.detached(priority: .background) {
            let backgroundRealm = try Realm(configuration: Config.realmConfiguration) // new Realm instance for background thread
            
            try backgroundRealm.write {
                backgroundRealm.add(
                    countries.compactMap { $0.toRealm() },
                    update: .all
                )
            }
        }.value
    }
    
    func loadCountries() async throws -> [Country] {
        
        try await Task.detached(priority: .background) {
            let realm = try Realm(configuration: Config.realmConfiguration) // new Realm instance on background thread
            let results = realm.objects(CountryRealm.self)
            
            // Convert to plain structs (thread-safe)
            let countries = results.map { $0.toEntity() }
            return Array(countries)
        }.value
        
    }
    
    func toggleFavorite(country: Country) async throws -> Country {
        
        try await Task.detached(priority: .background) {
            var c = country
            c.isFavorited = !(country.isFavorited ?? false)
            
            let backgroundRealm = try Realm(configuration: Config.realmConfiguration) // new Realm instance for background thread
            
            try backgroundRealm.write {
                backgroundRealm.add(c.toRealm(), update: .all)
            }
            
            return c
        }.value
        
    }
    
    func getFavoritedCountries() async throws -> [Country] {
        
        try await Task.detached(priority: .background) {
            let realm = try Realm(configuration: Config.realmConfiguration) // new Realm instance on background thread
            let results = realm.objects(CountryRealm.self)
            
            // Convert to plain structs (thread-safe)
            let countries = results.map { $0.toEntity() }.filter({ $0.isFavorited == true })
            return Array(countries)
        }.value
        
    }
    
}

