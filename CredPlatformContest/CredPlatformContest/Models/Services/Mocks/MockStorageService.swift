//
//  MockStorageService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

class MockStorageService : StorageServiceProtocol {
    func getFavoritedCountries() async throws -> [Country] {
        return []
    }
    
    func insertCountries(countries: [Country]) async throws {}
    func loadCountries() async throws -> [Country] {
        return []
    }
    func toggleFavorite(country: Country) async throws -> Country {
        var c = country
        c.isFavorited = !(country.isFavorited ?? false)
        return c
    }
    
}
