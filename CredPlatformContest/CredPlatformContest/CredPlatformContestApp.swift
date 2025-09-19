//
//  CredPlatformContestApp.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import SwiftUI

@main
struct CredPlatformContestApp: App {
    
    var body: some Scene {
        WindowGroup {
            
            // Real
            let apiService = GQLAPIService()
            let llmService = OpenAIService()
            let storageService = RealmService()
            let countryViewModel = CountryViewModel(apiService: apiService, llmService: llmService, storageService: storageService)
            
            CountryListView(countryViewModel: countryViewModel)
            
        }
    }
    
}
