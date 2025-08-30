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
        
        let prompt = String(format: StringSettings.normalRoastLevelPrompt, tipController.returnPromptRoastingTier(tipPercentage))
        if let aiComment = try? await aiService.getAIResponse(prompt: prompt) {
            let data = Data(aiComment.utf8)
            let tipComment = try? JSONDecoder().decode(TipComment.self, from: data)
            return extractComment(from: tipComment?.comment ?? tipController.fetchTipCommentFromLocal(tipPercentage: tipPercentage))
        } else {
            return tipController.fetchTipCommentFromLocal(tipPercentage: tipPercentage)
        }
    }
    
    fileprivate func extractComment(from aiComment: String) -> String {
        if let range = aiComment.range(of: ":") {
            var subString = aiComment[range.upperBound...]
            subString.removeLast()
            return String(subString)
        }
        return aiComment
    }
}
