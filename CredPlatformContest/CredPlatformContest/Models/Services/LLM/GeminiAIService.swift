//
//  GeminiAIService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import Foundation

class GeminiAIService : BaseLLMService {
    
    override func generateCountryFunFact(country: Country, question: String?) async throws -> CountryFunFact? {
        
        var prompt = "Generate a fun fact about the country \(country.name)"
        
        if let question = question, !question.isEmpty {
            prompt = "\(question) about \(country.name)"
        }
        
        let request = GeminiAIRequest(contents: [GeminiAIContent(parts: [GeminiAIPart(text: prompt)])])
        
        do {
            let response = try await sendLLMRequest(
                to: "https://generativelanguage.googleapis.com/v1beta/models/\(self.model):generateContent",
                request: request
            )
            
            return CountryFunFact(country: country, funFact: response?.generatedText() ?? "")
        } catch {
            print("Error: \(error)")
            return nil
        }
        
    }
    
    override func sendLLMRequest(to urlString: String, request: AIRequestProtocol) async throws -> AIResponseProtocol? {
        
        guard let url = URL(string: urlString) else { throw LLMError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue(self.apiKey, forHTTPHeaderField: "x-goog-api-key")
        urlRequest.httpBody = try request.toJSONData()
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            let errorMsg = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw LLMError.apiError(errorMsg)
        }
        
        let dataString = String(data: data, encoding: .utf8)
        print("response = \(dataString ?? "")")
        
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            let decodedResponse = try JSONDecoder().decode(GeminiAIResponse.self, from: data)
            return decodedResponse
        } catch {
            print(error)
        }
        
        return nil
        
    }
    
}
