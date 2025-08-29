//
//  StringSettings.swift
//  HitTips
//
//  Created by Matt Martindale on 8/26/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation

struct StringSettings {
    static var aIModel: String {"gpt-4o"}
    static var systemPrompt: String {"Response should be short, creative, have one property and be in JSON format"}
    static var normalRoastLevelPrompt: String {"roast a %@ tip I left at a restaurant"}
    static var savageRoastLevelPrompt: String {"Do the meanest roast of a %@ tip I made at a restaurant"}
}
