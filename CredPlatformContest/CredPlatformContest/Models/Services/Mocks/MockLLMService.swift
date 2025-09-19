//
//  MockLLMService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

class MockLLMService : BaseLLMService {
    
    var shouldFailed : Bool = false
    var shouldFailedQuestion : Bool = false
    
    override func generateCountryFunFact(country: Country, question: String?) async throws -> CountryFunFact? {
        if shouldFailed {
            throw Error.ErrorNotFound
        }
        
        if let question = question, !question.isEmpty {
            if shouldFailedQuestion == false {
                return CountryFunFact(country: country, funFact: "Country fun fact for your question (\(question))")
            }
            
            return CountryFunFact(country: country, funFact: "Country fun fact for your question")
        }
        
        return CountryFunFact(country: country, funFact: "Country fun fact")
    }
        
}
