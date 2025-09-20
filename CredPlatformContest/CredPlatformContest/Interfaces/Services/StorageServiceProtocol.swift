//
//  StorageServiceProtocol.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

protocol StorageServiceProtocol {
    
    func insertCountries(countries: [Country]) async throws
    func loadCountries() async throws -> [Country]
    func toggleFavorite(country: Country) async throws -> Country
    func getFavoritedCountryCodes() async throws -> [ID]
    
}
