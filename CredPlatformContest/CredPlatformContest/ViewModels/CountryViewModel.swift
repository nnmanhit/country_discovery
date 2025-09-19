//
//  CountryListViewModel.swift
//  CountryDiscovery
//
//  Created by Manh Nguyen on 9/18/25.
//

import Combine

class CountryViewModel : CountryViewModelProtocol {
    
    @Published var errorMessage : String? = nil
    @Published var countries : [Country] = []
    
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
            
            let countries = try await apiService.loadCountries()
            
            await MainActor.run {
                self.countries = countries
            }
            
        } catch {
            print("error - \(error)")
            self.errorMessage = error.localizedDescription
        }
        
    }
    
}
