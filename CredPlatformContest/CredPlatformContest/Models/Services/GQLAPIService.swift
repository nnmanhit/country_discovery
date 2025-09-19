//
//  CountryService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import Apollo

class GQLAPIService : APIServiceProtocol {
    
    static var apolloProd: ApolloClient? = nil
    static var apolloStage: ApolloClient? = nil
    
    var apollo: ApolloClient {
        get {
            
            var urlString = "https://countries.trevorblades.com/"
            var url = URL(string: "https://countries.trevorblades.com/")!
            
            if Config.env == .Prod {
                
                if let ap = GQLAPIService.apolloProd {
                    return ap
                }
                
                GQLAPIService.apolloProd = ApolloClient(networkTransport: HTTPNetworkTransport(url: url))
                return GQLAPIService.apolloProd!
            }
            
            // TO-DO:
            // We don't have the stage env yet.
            // Need to change this
            
            if let ap = GQLAPIService.apolloStage {
                return ap
            }
            
            url = URL(string: "https://countries.trevorblades.com/")!
            return GQLAPIService.apolloStage!
        }
    }
    
    func loadCountries() async throws -> [Country] {
        
        let query = CountriesQuery(lang: Config.lang)
        
        return try await withCheckedThrowingContinuation { continuation in
            
            apollo.fetch(query: query, cachePolicy: .fetchIgnoringCacheCompletely) { result in
                
                guard let jsonObject = try? result.get().data?.jsonObject else {
                    continuation.resume(throwing: Error.ErrorNotFound)
                    return
                }
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
                    let res = try JSONDecoder().decode(CountryResponse.self, from: data)
                    
                    continuation.resume(with: .success(res.countries?.sorted(by: { $0.name.lowercased() < $1.name.lowercased() }) ?? []))
                    
                } catch {
                    print(error)
                    continuation.resume(throwing: error)
                }
                
            }
            
        }
        
    }
    
}
