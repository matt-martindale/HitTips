//
//  AIService.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation

class AIService {
    private let networkManager = NetworkManager()
    private let requestBuilder = RequestBuilder()
    private let url = URL(string: "https://api.openai.com/v1/chat/completions")
    
    func getAIResponse(prompt: String) async -> String {
        guard let request = requestBuilder.buildRequest(prompt: prompt, url: url) else { return "Failed to generate AI response" }
        
        do {
            let data = try await networkManager.sendRequest(request)
            return decodeResponse(data)
        } catch {
            return "Failed to send request"
        }
    }
    
    private func decodeResponse(_ data: Data) -> String {
        do {
            let aiResponse = try JSONDecoder().decode(AIResponse.self, from: data)
            if let error = aiResponse.error {
                return error.message ?? "Error"
            }
            guard let choices = aiResponse.choices?.first,
                  let message = choices.message,
                  let content = message.content else { return "Nil value found in response"}
            return content
        } catch {
            return "Error decoding response"
        }
    }
}
