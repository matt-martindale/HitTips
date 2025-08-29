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
    let adFrequencyString = "adFrequency"
    let adCountString = "adCount"
    
    func shouldShowAd() -> Bool {
        let adCount = fetchAdCountFromUserDefaults()
        let adFrequency = fetchAdFrequencyFromUserDefaults()
        return adCount >= adFrequency
    }
    
    func saveAdFrequency() {
        fetchAdFrequency { [weak self] adFrequency in
            guard let adFrequency = adFrequency,
            let self = self else {
                self?.updateAdFrequencyToUserDefaults(3)
                return
            }
            self.updateAdFrequencyToUserDefaults(adFrequency)
        }
    }

    fileprivate func fetchAdFrequency(completion: @escaping (Int?) -> Void) {
        let db = Firestore.firestore()
        
        db.collection("adFrequency").document(Keys.adFrequencyId).getDocument { document, error in
            guard error == nil else {
                print(error?.localizedDescription as Any)
                completion(nil)
                return
            }
            
            if let document = document, document.exists {
                guard let data = document.data() else {
                    print("Error encoding Data")
                    completion(nil)
                    return
                }
                
                guard let adFrequency = data["adFrequency"] as? Int else {
                    completion(nil)
                    return
                }
                completion(adFrequency)
            }
        }
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
    
    func resetAdCount() {
        userDefaults.set(0, forKey: adCountString)
    }
    
}
