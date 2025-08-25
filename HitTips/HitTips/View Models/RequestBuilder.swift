//
//  RequestBuilder.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation

class RequestBuilder {
    
    func buildRequest(prompt: String, url: URL?) -> URLRequest? {
        guard let apiUrl = url else { return nil }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("Bearer \(APIKey.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "model": "gpt-4o-mini",
            "messages": [
                ["role": "user", "content": prompt]
            ]
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return nil }
        request.httpBody = jsonData

        return request
    }
}
