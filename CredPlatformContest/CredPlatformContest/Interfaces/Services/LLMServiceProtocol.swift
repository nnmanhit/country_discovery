//
//  Untitled.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

protocol LLMServiceProtocol {
    
    func generateCountryFunFact(country: Country, question: String?) async throws -> CountryFunFact?
    
}
