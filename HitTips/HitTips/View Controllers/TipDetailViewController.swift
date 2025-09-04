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
    @IBOutlet weak var hitTipsLogoStackView: UIStackView!
    @IBOutlet weak var commentTextView: UITextView!
    @IBOutlet weak var billAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var pricePerPersonLabel: UILabel!
    @IBOutlet weak var totalBillLabel: UILabel!
    let favoriteButton = UIButton(type: .system)
    let shareButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.setupHeaderButtons()
            self.setupHeaderLogo()
            self.setupViews()
            let expandingButton = ExpandingButton(frame: .zero)
            expandingButton.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(expandingButton)
            
            // Use an existing layout guide to ensure proper spacing
            let safeArea = self.view.safeAreaLayoutGuide
            
            // Define the maximum possible size for the expanding button's container
            // and place it in the top-right corner.
            NSLayoutConstraint.activate([
                expandingButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
                expandingButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 80),
                
                // Explicitly set the width and height of the ExpandingButton container
                // to accommodate the largest state of the expanded view.
                expandingButton.widthAnchor.constraint(equalToConstant: expandingButton.expandedWidth),
                expandingButton.heightAnchor.constraint(equalToConstant: expandingButton.expandedHeight)
            ])
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
    
    @objc private func shareButtonTapped() {
        headerStackView.isHidden = true
        hitTipsLogoStackView.isHidden = false
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let screenshot = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        headerStackView.isHidden = false
        hitTipsLogoStackView.isHidden = true

        // set up activity view controller
        let imageToShare = [screenshot]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash

        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func setupHeaderButtons() {
        // Setup spacer view
        let spacerView = UIView()
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        headerStackView.addArrangedSubview(spacerView)
        
        // Setup pill view
        let pillView = UIStackView()
        pillView.axis = .horizontal
        pillView.spacing = 0
        pillView.backgroundColor = .HTDarkGray
        pillView.clipsToBounds = true
        headerStackView.addArrangedSubview(pillView)
        
        // Setup favorite button
        setupIsFavoriteButtonIcon()
        favoriteButton.setTitle(nil, for: .normal)
        favoriteButton.tintColor = .HTRed
        favoriteButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 4)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        pillView.addArrangedSubview(favoriteButton)
        
        // Setup share button
        shareButton.setTitle(nil, for: .normal)
        shareButton.tintColor = .white
        shareButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 8, right: 12)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .light, scale: .default)
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up", withConfiguration: config), for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
        pillView.addArrangedSubview(shareButton)
        pillView.layoutIfNeeded()
        pillView.layer.cornerRadius = (pillView.frame.height / 2)
    }
    
    private func setupHeaderLogo() {
        hitTipsLogoStackView.isUserInteractionEnabled = false
        hitTipsLogoStackView.isHidden = true
        let logoImage = UIImage(named: "HitTipsLogo")
        let logoImageView = UIImageView(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        hitTipsLogoStackView.addArrangedSubview(logoImageView)
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

