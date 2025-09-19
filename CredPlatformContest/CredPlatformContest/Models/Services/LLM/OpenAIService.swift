//
//  OpenAIService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import Foundation

class OpenAIService : BaseLLMService {
    
    override func generateCountryFunFact(country: Country, question: String?) async throws -> CountryFunFact? {
        
        var prompt = "Generate a fun fact about the country \(country.name)"
        
        if let question = question, !question.isEmpty {
            prompt = "\(question) about \(country.name)"
        }
        
        let openAIRequest = OpenAIRequest(model: "gpt-3.5-turbo", input: prompt)

        do {
            let response = try await sendLLMRequest(to: "https://api.openai.com/v1/responses", request: openAIRequest)
            
            print("Response: \(response?.generatedText() ?? "")")
            
            let countryFunFact = CountryFunFact(country: country, funFact: response?.generatedText() ?? "")
            return countryFunFact
        } catch {
            print("Error: \(error)")
        }
        
        return nil
        
    }
    
    override func sendLLMRequest(to urlString: String, request: AIRequestProtocol) async throws -> AIResponseProtocol? {
        
        guard let url = URL(string: urlString) else { throw LLMError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(self.apiKey)", forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = try request.toJSONData()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            let errorMsg = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw LLMError.apiError(errorMsg)
        }
        
        let dataString = String(data: data, encoding: .utf8)
        print("response = \(dataString ?? "")")
        
        do {
            let decodedResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
            return decodedResponse
        } catch {
            print(error)
        }
        
        return nil
        
    }
    
}
