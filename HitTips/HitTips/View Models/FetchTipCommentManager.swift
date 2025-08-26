//
//  FetchTipCommentManager.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation
import Combine

struct TipComment: Codable {
    let comment: String
}

class FetchTipCommentManager {
    
    let aiService = AIService()
    let tipController = TipController()
    
    func fetchTipComment(_ tipPercentage: Int64) async -> String {
        
        if let aiComment = try? await aiService.getAIResponse(prompt: "roast a tip someone left at a restaurant") {
            let data = Data(aiComment.utf8)
            let tipComment = try? JSONDecoder().decode(TipComment.self, from: data)
            return extractComment(from: tipComment?.comment ?? "Be better", tipPercentage)
        } else {
            return tipController.fetchTipCommentFromLocal(tipPercentage: tipPercentage)
        }
    }
    
    fileprivate func extractComment(from aiComment: String, _ tipPercentage: Int64) -> String {
        if aiComment.contains("\"roast\"") || aiComment.contains("\"message\"") || aiComment.contains("\"comment\"") {
            return tipController.fetchTipCommentFromLocal(tipPercentage: tipPercentage)
        } else {
            return aiComment
        }
    }
}
