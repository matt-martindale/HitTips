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
    let favoriteButton = UIButton(type: .system)
    
    
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
    
    @objc private func favoriteButtonTapped() {
        guard let tip = tip else { return }
        tip.isFavorite.toggle()
        setupIsFavoriteButtonIcon()
        saveToCoreData()
    }
    
    private func setupIsFavoriteButton() {
        setupIsFavoriteButtonIcon()
        favoriteButton.setTitle(nil, for: .normal)
        favoriteButton.tintColor = .HTRed
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        headerStackView.addArrangedSubview(favoriteButton)
    }
    
    private func setupIsFavoriteButtonIcon() {
        let favoriteIconName = (tip?.isFavorite ?? false) ? "heart.fill" : "heart"
        if let favoriteIcon = UIImage(systemName: favoriteIconName) {
            favoriteButton.setImage(favoriteIcon, for: .normal)
        }
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
    
    private func saveToCoreData() {
        let context = CoreDataStack.shared.mainContext
        
        do {
            try context.save()
        } catch {
            NSLog("Error saving context to persistent store")
            context.reset()
        }
    }
    
}

