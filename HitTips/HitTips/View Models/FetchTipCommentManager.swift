//
//  FetchTipCommentManager.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation

class FetchTipCommentManager {
    
    var tipController = TipController()
    
    func fetchTipComment(_ tipPercentage: Int64) -> String {
        return tipController.fetchTipCommentFromLocal(tipPercentage: tipPercentage)
    }
}
