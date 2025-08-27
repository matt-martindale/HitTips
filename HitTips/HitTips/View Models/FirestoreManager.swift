//
//  FirestoreManager.swift
//  HitTips
//
//  Created by Matt Martindale on 8/26/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import Foundation
import Firebase

class FirestoreManager {
    func fetchAiApiKey() -> String {
        let db = Firestore.firestore()
        var apiKey: String?
        
        db.collection("keys").document(Keys.FirestoreAiApiKeyDocumentId).getDocument { document, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            if let document = document, document.exists {
                guard let data = document.data() else {
                    print("Error encoding Data")
                    return
                }
                
                apiKey = document["aiApiKey"] as? String
            }
        }
        return apiKey ?? ""
    }
}
