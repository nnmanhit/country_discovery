//
//  CredPlatformContestTests.swift
//  CredPlatformContestTests
//
//  Created by Manh Nguyen on 9/18/25.
//

import XCTest
@testable import CredPlatformContest

final class CredPlatformContestTests: XCTestCase {

    var mockApiService : MockAPIService?
    var mockLlmService : OpenAIService?
    var mockStorageService : RealmService?
    var countryViewModel : CountryViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadCountriesSuccessfully() async throws {
        
        self.mockApiService = MockAPIService()
        
        self.mockLlmService = OpenAIService()
        self.mockStorageService = RealmService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.loadCountries()
        
        XCTAssertTrue((self.countryViewModel?.countries.count ?? 0) > 0)
        
    }
    
    func testLoadCountriesError() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockApiService?.shouldThrowError = true
        
        self.mockLlmService = OpenAIService()
        self.mockStorageService = RealmService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.loadCountries()
        
        XCTAssertTrue(self.countryViewModel?.errorMessage != nil)
        
    }

}
