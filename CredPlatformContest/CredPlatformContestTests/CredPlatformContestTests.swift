//
//  CredPlatformContestTests.swift
//  CredPlatformContestTests
//
//  Created by Manh Nguyen on 9/18/25.
//

import XCTest
@testable import CredPlatformContest

final class CredPlatformContestTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoadCountriesSuccessfully() async throws {
        
        let mockApiService = MockAPIService()
        
        let mockLlmService = MockLLMService(apiKey: Config.OAK ?? "", model: "gpt-3.5-turbo")
        let mockStorageService = MockStorageService()
        
        let countryListViewModel = CountryListViewModel(apiService: mockApiService, storageService: mockStorageService)
        
        await countryListViewModel.loadCountries()
        
        XCTAssertTrue((countryListViewModel.countries.count ?? 0) > 0)
        
    }
    
    func testLoadCountriesError() async throws {
        
        let mockApiService = MockAPIService()
        mockApiService.shouldThrowError = true
        let mockStorageService = MockStorageService()
        
        let countryListViewModel = CountryListViewModel(apiService: mockApiService, storageService: mockStorageService)
        
        await countryListViewModel.loadCountries()
        
        XCTAssertTrue(countryListViewModel.errorMessage != nil)
        
    }
    
    func testLoadCountryFuncFactFailed() async throws {
        
        let mockLlmService = MockLLMService(apiKey: Config.OAK ?? "", model: "gpt-3.5-turbo")
        mockLlmService.shouldFailed = true
        
        let countrySummaryViewModel = CountrySummaryViewModel(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), llmService: mockLlmService)
        
        await countrySummaryViewModel.generateCountryFunFact(question: nil)
        XCTAssertTrue(countrySummaryViewModel.errorMessage != nil)
        
    }
    
    func testLLMInvalidKey() async throws {
        
        let mockLlmService = MockLLMService(apiKey: "123", model: "gpt-3.5-turbo")
        
        let mockStorageService = MockStorageService()
        
        let countrySummaryViewModel = CountrySummaryViewModel(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), llmService: mockLlmService)
        
        await countrySummaryViewModel.generateCountryFunFact(question: nil)
        
        XCTAssertTrue(countrySummaryViewModel.errorMessage == Error.ErrorInvalidKey.localizedDescription)
        
    }
    
    func testLoadCountryFuncFactSuccessfully() async throws {
        
        let mockLlmService = MockLLMService(apiKey: Config.OAK ?? "", model: "gpt-3.5-turbo")
        
        let countrySummaryViewModel = CountrySummaryViewModel(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), llmService: mockLlmService)
        
        await countrySummaryViewModel.generateCountryFunFact(question: nil)
        XCTAssertTrue(countrySummaryViewModel.countryFunFact != nil)
        
    }
    
    func testLoadCountryFuncFactWithQuestionSuccessfully() async throws {
        
        let mockLlmService = MockLLMService(apiKey: Config.OAK ?? "", model: "gpt-3.5-turbo")
        
        let countrySummaryViewModel = CountrySummaryViewModel(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), llmService: mockLlmService)
        
        sleep(2)
        
        await countrySummaryViewModel.generateCountryFunFact(question: "I want to know more")
        XCTAssertTrue(countrySummaryViewModel.countryFunFact?.funFact == "OK More")
        
    }
    
    func testLoadCountryFuncFactWithQuestionFailed() async throws {
        
        let mockLlmService = MockLLMService(apiKey: Config.OAK ?? "", model: "gpt-3.5-turbo")
        mockLlmService.shouldFailedQuestion = true
        
        let countrySummaryViewModel = CountrySummaryViewModel(country: Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America")), llmService: mockLlmService)
        
        await countrySummaryViewModel.generateCountryFunFact(question: "I want to know more")
        XCTAssertTrue(countrySummaryViewModel.errorMessage == Error.ErrorOnQuestion.localizedDescription)
        
    }
    
    func testToggleFavoriteCountryOn() async throws {
        
        let mockApiService = MockAPIService()
        let mockStorageService = MockStorageService()
        
        let countryListViewModel = CountryListViewModel(apiService: mockApiService, storageService: mockStorageService)
        await countryListViewModel.loadCountries()
        
        let country = Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America"), isFavorited: false)
        await countryListViewModel.toggleFavorite(country)
        
        XCTAssertTrue(countryListViewModel.toggledCountry?.isFavorited == true)
        
    }
    
    func testToggleFavoriteCountryOff() async throws {
        
        let mockApiService = MockAPIService()
        let mockStorageService = MockStorageService()
        
        let countryListViewModel = CountryListViewModel(apiService: mockApiService, storageService: mockStorageService)
        await countryListViewModel.loadCountries()
        
        let country = Country(name: "USA", code: "US", currency: "USD", capital: "Washington DC", emoji: "usa", languages: [], continent: Continent(code: "AM", name: "America"), isFavorited: true)
        await countryListViewModel.toggleFavorite(country)
        
        XCTAssertTrue(countryListViewModel.toggledCountry?.isFavorited == false)
        
    }

}
