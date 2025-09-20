//
//  UseDefaultService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/20/25.
//

import Foundation

struct UserDefaultService : StorageServiceProtocol {
    
    static var COUNTRY_CACHE : String = "kCountryCacheKey"
    static var FAVORITE_COUNTRY_CACHE : String = "kFavoriteCountryCache"
    
    func insertCountries(countries: [Country]) async throws {
        
        do {
            
            let data = try JSONEncoder().encode(countries)
            
            mainUserDefaults.setValue(String(data: data, encoding: .utf8), forKey: UserDefaultService.COUNTRY_CACHE)
            mainUserDefaults.synchronize()
            
        } catch {
            print("error - \(error)")
        }

    }
    
    func loadCountries() async throws -> [Country] {
        
        let cache = mainUserDefaults.value(forKey: UserDefaultService.COUNTRY_CACHE) as? String
        do {
            
            let data = cache?.data(using: .utf8)
            if let data = data {
                var countries = try JSONDecoder().decode([Country].self, from: data)
                
                let favoriteCountryCodes = try await self.getFavoritedCountryCodes()
                for i in 0..<countries.count {
                    if favoriteCountryCodes.contains(countries[i].code) {
                        let country = countries[i]
                        countries[i].isFavorited = true
                    }
                }
                
                return countries
            }
            
        } catch {
            print("error - \(error)")
        }
        
        return []
        
    }
    
    func toggleFavorite(country: Country) async throws -> Country {
        
        var ct = country
        ct.isFavorited = !(country.isFavorited ?? false)
        let favorite = ct.isFavorited
        
        var favoriteCts = mainUserDefaults.stringArray(forKey: UserDefaultService.FAVORITE_COUNTRY_CACHE) ?? []
        
        if favorite == true {
            if !favoriteCts.contains(country.code) {
                favoriteCts.append(country.code)
            }
        } else {
            favoriteCts.removeAll(where: { $0 == country.code })
        }
        
        mainUserDefaults.setValue(favoriteCts, forKey: UserDefaultService.FAVORITE_COUNTRY_CACHE)
        mainUserDefaults.synchronize()
        
        return ct
    }
    
    func getFavoritedCountryCodes() async throws -> [ID] {
        let cacheFavoriteCts = mainUserDefaults.stringArray(forKey: UserDefaultService.FAVORITE_COUNTRY_CACHE) ?? []
        return cacheFavoriteCts
    }
    
}
