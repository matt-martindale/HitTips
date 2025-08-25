//
//  AIResponse.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation

struct AIResponse: Codable {
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let choices: [Choice]?
    let error: AIError?
}

struct Choice: Codable {
    let index: Int?
    let message: Message?
    let logprobs: String?
    let finish_reason: String?
}

struct Message: Codable {
    let role: String?
    let content: String?
}

struct AIError: Codable {
    let message: String?
}
