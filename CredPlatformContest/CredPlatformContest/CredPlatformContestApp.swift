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
            
            // Easy change AI Service by initialize GeminiAIService
//            let llmService = GeminiAIService(apiKey: Config.GAK, model: "gemini-2.5-flash")
//            let storageService = RealmService()
            
            let storageService = UserDefaultService()
            let countryListViewModel = CountryListViewModel(apiService: apiService, storageService: storageService)
            
            CountryListView(countryListViewModel: countryListViewModel)
            
        }
    }
    
}
