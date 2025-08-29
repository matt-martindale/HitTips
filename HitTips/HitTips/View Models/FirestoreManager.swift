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
    let userDefaults = UserDefaults.standard
    let aiModelString = "aiModel"
    let adFrequencyString = "adFrequency"
    let adCountString = "adCount"
    
    init() {
        fetchAppSettingsAndSaveToUserDefaults()
    }
    
    func fetchAppSettingsAndSaveToUserDefaults() {
        let db = Firestore.firestore()
        
        db.collection("appSettings").document(Keys.firestoreAppSettings).getDocument { [weak self] document, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                return
            }
            
            if let document = document, document.exists {
                guard let data = document.data() else {
                    print("Error encoding Data")
                    return
                }
                
                // map app settings and provide default value
                let aiModel = data["aiModel"] as? String ?? "gpt-4o-mini"
                let adFrequency = data["adFrequency"] as? Int ?? 2
                
                print("AI model:\(aiModel), Ad frequency:\(adFrequency)")
                
                // Save to user defaults
                self?.updateAiModelToUserDefaults(aiModel)
                self?.updateAdFrequencyToUserDefaults(adFrequency)
            }
        }
    }
    
    private func updateAiModelToUserDefaults(_ aiModel: String) {
        userDefaults.set(aiModel, forKey: aiModelString)
    }
    
    private func updateAdFrequencyToUserDefaults(_ adFrequency: Int) {
        userDefaults.set(adFrequency, forKey: adFrequencyString)
    }
    
    func fetchAdFrequencyFromUserDefaults() -> Int {
        (userDefaults.value(forKey: adFrequencyString) as? Int) ?? 3
    }
    
    func fetchAdCountFromUserDefaults() -> Int {
        (userDefaults.value(forKey: adCountString) as? Int) ?? 0
    }
    
    func incrementAdCount() {
        var adCount = fetchAdCountFromUserDefaults()
        adCount += 1
        userDefaults.set(adCount, forKey: adCountString)
    }
    
    func shouldShowAd() -> Bool {
        let adCount = fetchAdCountFromUserDefaults()
        let adFrequency = fetchAdFrequencyFromUserDefaults()
        return adCount >= adFrequency
    }
    
    func resetAdCount() {
        userDefaults.set(0, forKey: adCountString)
    }
    
}
