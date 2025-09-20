//
//  CountrySummaryViewModel.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/20/25.
//

import Combine

class CountrySummaryViewModel : CountrySummaryViewModelProtocol {
    
    @Published var errorMessage : String? = nil
    @Published var countryFunFact : CountryFunFact? = nil
    @Published var isLoading : Bool = false
    
    let country : Country
    let llmService : LLMServiceProtocol
    
    init(country: Country, llmService: LLMServiceProtocol) {
        self.country = country
        self.llmService = llmService
        
        self.countryFunFact?.funFact = ""
        
        Task {
            await self.generateCountryFunFact(question: nil)
        }
    }
    
    func generateCountryFunFact(question: String?) async {
        
        do {
            
            await MainActor.run {
                self.isLoading = true
            }
            
            let countryFunFact = try await llmService.generateCountryFunFact(country: country, question: question)
            await MainActor.run {
                self.countryFunFact = countryFunFact
                self.isLoading = false
            }
            
        } catch {
            print("error - \(error)")
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
        
    }
    
}
