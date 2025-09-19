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
    var mockLlmService : MockLLMService?
    var mockStorageService : MockStorageService?
    var countryViewModel : CountryViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadCountriesSuccessfully() async throws {
        
        self.mockApiService = MockAPIService()
        
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.loadCountries()
        
        XCTAssertTrue((self.countryViewModel?.countries.count ?? 0) > 0)
        
    }
    
    func testLoadCountriesError() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockApiService?.shouldThrowError = true
        
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.loadCountries()
        
        XCTAssertTrue(self.countryViewModel?.errorMessage != nil)
        
    }
    
    func testLoadCountryFuncFactFailed() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockLlmService?.shouldFailed = true
        
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.generateCountryFunFact(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), question: nil)
        
        XCTAssertTrue(self.countryViewModel?.errorMessage != nil)
        
    }
    
    func testLLMInvalidKey() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: "123", model: "gpt-3.5-turbo")
        
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.generateCountryFunFact(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), question: nil)
        
        XCTAssertTrue(self.countryViewModel?.errorMessage != nil)
        
    }
    
    func testLoadCountryFuncFactSuccessfully() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.generateCountryFunFact(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), question: nil)
        
        XCTAssertTrue(self.countryViewModel?.countryFunFact != nil)
        
    }
    
    func testLoadCountryFuncFactWithQuestionSuccessfully() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.generateCountryFunFact(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), question: "I want to know more")
        
        XCTAssertTrue(self.countryViewModel?.countryFunFact?.funFact.contains("I want to know more") == true)
        
    }
    
    func testLoadCountryFuncFactWithQuestionFailed() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockLlmService?.shouldFailedQuestion = true
        
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        
        await self.countryViewModel?.generateCountryFunFact(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), question: "I want to know more")
        
        XCTAssertTrue(self.countryViewModel?.countryFunFact?.funFact.contains("I want to know more") == false)
        
    }
    
    func testToggleFavoriteCountryOn() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        await self.countryViewModel?.loadCountries()
        
        let country = Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America"))
        await self.countryViewModel?.toggleFavorite(country)
        
        XCTAssertTrue(self.countryViewModel?.toggledCountry?.isFavorited == true)
        
    }
    
    func testToggleFavoriteCountryOff() async throws {
        
        self.mockApiService = MockAPIService()
        self.mockLlmService = MockLLMService(apiKey: Config.OPENAI_API_KEY ?? "", model: "gpt-3.5-turbo")
        self.mockStorageService = MockStorageService()
        
        self.countryViewModel = CountryViewModel(apiService: mockApiService!, llmService: mockLlmService!, storageService: mockStorageService!)
        await self.countryViewModel?.loadCountries()
        
        let country = Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America"), isFavorited: true)
        await self.countryViewModel?.toggleFavorite(country)
        
        XCTAssertTrue(self.countryViewModel?.toggledCountry?.isFavorited == false)
        
    }

}
