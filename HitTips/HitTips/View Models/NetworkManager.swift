//
//  NetworkManager.swift
//  HitTips
//
//  Created by Matt Martindale on 8/24/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation

class NetworkManager {
    func sendRequest(_ request: URLRequest) async throws -> Data {
        let (responseData, _) = try await
        URLSession.shared.data(for: request)
        return responseData
    }
}
