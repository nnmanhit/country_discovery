//
//  CountryListViewModel.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import Combine
import Foundation

class CountryListViewModel : CountryViewModelProtocol {
    
    @Published var errorMessage : String? = nil
    @Published var countries : [Country] = []
    @Published var toggledCountry : Country? = nil
    @Published var isLoading : Bool = false
    
    let apiService : APIServiceProtocol
    let storageService : StorageServiceProtocol
    
    init(apiService: APIServiceProtocol, storageService: StorageServiceProtocol) {
        self.apiService = apiService
        self.storageService = storageService
        
        Task {
            await loadCountries()
        }
    }
    
    func loadCountries() async {
        
        do {
            
            await MainActor.run {
                self.isLoading = true
            }
            
            var loadedCountries = try await apiService.loadCountries()
            let favoriteCountryCodes = try await storageService.getFavoritedCountryCodes()

            for i in 0..<loadedCountries.count {
                if favoriteCountryCodes.contains(loadedCountries[i].code) {
                    loadedCountries[i].isFavorited = true
                }
            }

            if !loadedCountries.isEmpty {
                try await storageService.insertCountries(countries: loadedCountries)
            }

            await MainActor.run {
                self.countries = loadedCountries
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
