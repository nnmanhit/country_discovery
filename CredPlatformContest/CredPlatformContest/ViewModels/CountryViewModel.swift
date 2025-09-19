//
//  CountryListViewModel.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import Combine
import Foundation

class CountryViewModel : CountryViewModelProtocol {
    
    @Published var errorMessage : String? = nil
    @Published var countries : [Country] = []
    @Published var countryFunFact : CountryFunFact? = nil
    @Published var toggledCountry : Country? = nil
    @Published var isLoading : Bool = false
    
    let apiService : APIServiceProtocol
    let llmService : LLMServiceProtocol
    let storageService : StorageServiceProtocol
    
    init(apiService: APIServiceProtocol, llmService: LLMServiceProtocol, storageService: StorageServiceProtocol) {
        self.apiService = apiService
        self.llmService = llmService
        self.storageService = storageService
    }
    
    func loadCountries() async {
        
        do {
            
            await MainActor.run {
                self.isLoading = true
            }
            
            let loadedCountries = try await apiService.loadCountries()
            let favoriteCountries = try await storageService.getFavoritedCountries()
            let favoriteCodes = Set(favoriteCountries.map { $0.code })

            let countriesToUse = loadedCountries.map { country in
                var c = country
                c.isFavorited = favoriteCodes.contains(c.code)
                return c
            }

            if !countriesToUse.isEmpty {
                try await storageService.insertCountries(countries: countriesToUse)
            }

            await MainActor.run {
                self.countries = countriesToUse
                self.isLoading = false
            }
            
        } catch {
            
            do {
                let cts = try await storageService.loadCountries()
                if !cts.isEmpty {
                    await MainActor.run {
                        self.countries = cts
                    }
                }
            } catch {
                print("error - \(error)")
            }
            
            print("error - \(error)")
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.isLoading = false
            }
        }
        
    }
    
    func generateCountryFunFact(country: Country, question: String?) async {
        
        do {
            
            let countryFunFact = try await llmService.generateCountryFunFact(country: country, question: question)
            await MainActor.run {
                self.countryFunFact = countryFunFact
            }
            
        } catch {
            print("error - \(error)")
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
        
    }
    
    func toggleFavorite(_ country: Country) async {
        
        do {
            
            let toggledCountry = try await storageService.toggleFavorite(country: country)
            
            for i in 0..<countries.count {
                if countries[i].code == toggledCountry.code {
                    
                    await MainActor.run {
                        self.toggledCountry = toggledCountry
                        countries[i] = toggledCountry
                        countries = countries
                    }
                    
                    break
                }
            }
            
            
        } catch {
            
        }
        
        
    }
    
}
