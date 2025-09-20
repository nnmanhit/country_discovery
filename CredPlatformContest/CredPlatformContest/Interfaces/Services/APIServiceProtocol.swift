//
//  CountryServiceProtocol.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

protocol APIServiceProtocol {
    
    func loadCountries() async throws -> [Country]
    
}
