//
//  BaseLLMService.swift
//  CredPlatformContest
//
//  Created by Manh Nguyen on 9/18/25.
//

import Foundation

class BaseLLMService : LLMServiceProtocol {
    
    let apiKey : String
    let model : String
    
    init(apiKey: String, model: String) {
        self.apiKey = apiKey
        self.model = model
    }
    
    func generateCountryFunFact(country: Country, question: String?) async throws -> CountryFunFact? {
        return nil
    }
    
    func sendLLMRequest(to urlString: String, request: AIRequestProtocol) async throws -> AIResponseProtocol? { return nil }
    
}

protocol AIRequestProtocol : Codable {
    func toJSONData() throws -> Data
}

struct OpenAIRequest : AIRequestProtocol {
    var model: String?
    var input: String?
    
    init(model: String? = nil, input: String? = nil) {
        self.model = model
        self.input = input
    }
    
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

struct GeminiAIRequest : AIRequestProtocol {
    
    var contents : [GeminiAIContent]?
    
    init(contents: [GeminiAIContent]? = nil) {
        self.contents = contents
    }
    
    func toJSONData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
}

protocol AIResponseProtocol : Codable {
    func generatedText() -> String
}

struct OpenAIResponse : AIResponseProtocol {
    
    var id: String?
    var output: [OpenAIOutput]?
    
    func generatedText() -> String {
        return output?.first?.content?.first?.text ?? ""
    }

}

struct OpenAIOutput : Codable {
    let id : String?
    let type : String?
    let status : String?
    let content : [OpenAIOutputContent]?
    let role : String?
}

struct OpenAIOutputContent : Codable {
    
    let type : String?
    let text : String?
    
}

struct GeminiAIResponse: AIResponseProtocol {
    let candidates: [GeminiAICandidate]?
    let usageMetadata: UsageMetadata?
    let modelVersion: String?
    let responseId: String?

    func generatedText() -> String {
        return candidates?.first?.content?.parts?.first?.text ?? ""
    }
}

struct GeminiAICandidate: Codable {
    let content: GeminiAIContent?   // <-- singular, not "contents"
    let finishReason: String?
    let index: Int?
}

struct GeminiAIContent: Codable {
    var parts: [GeminiAIPart]?
}

struct GeminiAIPart: Codable {
    let text: String?
}

struct UsageMetadata: Codable {
    let promptTokenCount: Int?
    let candidatesTokenCount: Int?
    let totalTokenCount: Int?
    let promptTokensDetails: [PromptTokensDetail]?
    let thoughtsTokenCount: Int?
}

struct PromptTokensDetail: Codable {
    let modality: String?
    let tokenCount: Int?
}

enum LLMError: Swift.Error {
    case invalidURL
    case invalidResponse
    case apiError(String)
}
