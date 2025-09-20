//
//  RealmService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

//import RealmSwift

class RealmService : StorageServiceProtocol {
    
    init() {

    }
    
    func insertCountries(countries: [Country]) async throws {
    }
    
    func loadCountries() async throws -> [Country] {
        return []
    }
    
    func toggleFavorite(country: Country) async throws -> Country {
        return country
    }
    
    func getFavoritedCountryCodes() async throws -> [String] {
        return []
    }
    
}

