//
//  MockAPIService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

class MockAPIService : APIServiceProtocol {
    
    var shouldThrowError = false
    
    var mockCountries: [Country] = [
        Country(name: "USA", code: "US", currency: "USD", capital: "Washington", languages: [Language(code: "EN", name: "English")])
    ]
    
    func loadCountries() async throws -> [Country] {
        
        if shouldThrowError {
            throw Error.ErrorNotFound
        }
        
        return mockCountries
    }
    
}
