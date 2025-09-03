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
    
    @IBOutlet weak var headerStackView: UIStackView!
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
            self.setupIsFavoriteButton()
            self.setupViews()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        interstitialAdDelegate?.refreshInterstitialAd()
    }
    
    private func setupIsFavoriteButton() {
        let favoriteButton = UIButton(type: .system)
        if let favoriteIcon = UIImage(systemName: "star") {
            favoriteButton.setImage(favoriteIcon, for: .normal)
        }
        favoriteButton.setTitle(nil, for: .normal)
        favoriteButton.tintColor = .HTGreen
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        headerStackView.addArrangedSubview(favoriteButton)
    }
    
    private func setupViews() {
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
    
    @objc private func favoriteButtonTapped() {
        print("favorite button tapped")
    }
    
}

