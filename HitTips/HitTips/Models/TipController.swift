//
//  TipController.swift
//  HitTips
//
//  Created by Matthew Martindale on 3/24/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import Foundation

class TipController {
    
    var tip: Tip? = nil
    var commentTier: TipTier? = nil
    let userDefaults = UserDefaults.standard
    
    var personAmount: [Int] {
        var peopleAmount: [Int] = []
        for person in 1...20 {
            peopleAmount.append(person)
        }
        return peopleAmount.reversed()
    }
    
    var tipPercentage: [Int] {
        var tipPercentage: [Int] = []
        for percent in 1...50 {
            tipPercentage.append(percent)
        }
        return tipPercentage.reversed()
    }
    
    func returnPromptRoastingTier(_ tipPercentage: Int64) -> String {
        switch tipPercentage {
        case 0...10:
            "terrible"
        case 11...19:
            "bad"
        case 20...29:
            "decent"
        case 30...999:
            "good"
        default:
            "bad"
        }
    }
    
    func fetchTipCommentFromLocal(tipPercentage: Int64) -> String {
        switch tipPercentage {
        case 420:
            return getRandomComment(tipTier: .fourTwenty)
        case 69:
            return getRandomComment(tipTier: .sixtyNine)
        case 666:
            return getRandomComment(tipTier: .sixsixsix)
        case 0...14:
            return getRandomComment(tipTier: .lowTier)
        case 15...29:
            return getRandomComment(tipTier: .midTier)
        case 30...999:
            return getRandomComment(tipTier: .highTier)
        case ...(-1):
            return getRandomComment(tipTier: .negativeHacker)
        default:
            return getRandomComment(tipTier: .hacker)
        }
    }
    
    func getRandomComment(tipTier: TipTier) -> String {
        let comments = Comments()
        
        switch tipTier {
        case .fourTwenty:
            let randomIndex = Int.random(in: 0..<comments.fourTwentyTier.count)
            return comments.fourTwentyTier[randomIndex]
        case .sixtyNine:
            let randomIndex = Int.random(in: 0..<comments.sixtyNineTier.count)
            return comments.sixtyNineTier[randomIndex]
        case .sixsixsix:
            let randomIndex = Int.random(in: 0..<comments.sixsixsixTier.count)
            return comments.sixsixsixTier[randomIndex]
        case .lowTier:
            let randomIndex = Int.random(in: 0..<comments.lowTier.count)
            return comments.lowTier[randomIndex]
        case .midTier:
            let randomIndex = Int.random(in: 0..<comments.midTier.count)
            return comments.midTier[randomIndex]
        case .highTier:
            let randomIndex = Int.random(in: 0..<comments.highTier.count)
            return comments.highTier[randomIndex]
        case .negativeHacker:
            let randomIndex = Int.random(in: 0..<comments.negativeHackerTier.count)
            return comments.negativeHackerTier[randomIndex]
        default:
            let randomIndex = Int.random(in: 0..<comments.hackerTier.count)
            return comments.hackerTier[randomIndex]
        }
    }
    
    func calculateTotalBill(billAmount: Double, tipAmount: Double, tipPercentage: Int) -> Double {
        return billAmount + calculateTipAmount(billAmount: billAmount, tipPercentage: tipPercentage)
    }
    
    func calculateTipAmount(billAmount: Double?, tipPercentage: Int?) -> Double {
        guard let billAmount = billAmount,
            let tipPercentage = tipPercentage else { return 0.0}
        let adjustedTipPercentage = Double(tipPercentage) / 100
        return billAmount * adjustedTipPercentage
    }
    
    func roundUp(oldTotalBill: Double) -> Double {
        return oldTotalBill.rounded(.up)
    }
    
    func roundDown(oldTotalBill: Double) -> Double {
        return oldTotalBill.rounded(.down)
    }
    
    func saveTipPercentageToUserDefaults(_ tipPercentage: Int) {
        userDefaults.setValue(tipPercentage, forKey: "tipPercentage")
    }
    
    func fetchTipPercentageFromUserDefaults(forPicker: Bool = false) -> Int {
        guard let value = userDefaults.value(forKey: "tipPercentage") as? Int else { return 15 }
        return forPicker ? (50 - value) : value
    }
    
}
