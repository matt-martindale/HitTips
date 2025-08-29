//
//  RequestBuilder.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation
import ConfidentialKit

class RequestBuilder {
    
    func buildRequest(prompt: String, url: URL?) -> URLRequest? {
        guard let apiUrl = url else { return nil }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.addValue("Bearer \(Secrets.$apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonSchema: [String: Any] = [
            "type": "object",
            "strict": true,
            "additionalProperties": false,
            "properties": [
                "comment": ["type": "string"],
            ],
            "required": ["comment"]
        ]
        
        let parameters: [String: Any] = [
            "model": StringSettings.aIModel,
            "messages":
                [
                    [
                        "role": "system", "content": [[
                            "type": "text",
                            "text": StringSettings.systemPrompt
                        ]]
                    ], [
                        "role": "user", "content": [[
                            "type": "text",
                            "text": prompt
                        ]]
                    ]
                ]
            ,
            "response_format": [
                "type": "json_schema",
                "json_schema": [
                    "name": "comment_schema",
                    "schema": jsonSchema
                ]
            ]
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else { return nil }
        request.httpBody = jsonData

        return request
    }
}
