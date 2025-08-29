//
//  TipDetailViewController.swift
//  HitTips
//
//  Created by Matthew Martindale on 3/24/20.
//  Copyright © 2020 Matthew Martindale. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol RefreshInterstitialAdDelegate {
    func refreshInterstitialAd()
}

class TipDetailViewController: UIViewController {
    
    var tipController: TipController?
    var tip: Tip?
    var interstitialAdDelegate: RefreshInterstitialAdDelegate?
    
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var pricePerPersonLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.updateViews()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        interstitialAdDelegate?.refreshInterstitialAd()
    }
    
    func updateViews() {
        if let billAmount = tip?.billAmount,
           let tipAmount = tip?.tipAmount,
           let tipPercentage = tip?.tipPercentage,
           let party = tip?.party,
           let pricerPerPerson = tip?.pricePerPerson,
           let totalBill = tip?.totalBill,
           let comment = tip?.tipTier {
            billAmountLabel.text = "$" + String(format: "%.2f", billAmount)
            tipAmountLabel.text = "$" + String(format: "%.2f", tipAmount)
            tipPercentageLabel.text = String(tipPercentage) + "%"
            partyLabel.text = String(party)
            pricePerPersonLabel.text = "$" + String(format: "%.2f", pricerPerPerson)
            totalBillLabel.text = "$" + String(format: "%.2f", totalBill)
            commentTextView.text = comment
        }
    }
}

