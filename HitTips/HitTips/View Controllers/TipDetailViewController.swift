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
        guard let tip = tip,
        let comment = tip.tipTier else { return }
        billAmountLabel.text = "$" + String(format: "%.2f", tip.billAmount)
        tipAmountLabel.text = "$" + String(format: "%.2f", tip.tipAmount)
        tipPercentageLabel.text = String(tip.tipPercentage) + "%"
        partyLabel.text = String(tip.party)
        pricePerPersonLabel.text = "$" + String(format: "%.2f", tip.pricePerPerson)
        totalBillLabel.text = "$" + String(format: "%.2f", tip.totalBill)
        commentTextView.text = comment
    }
}

