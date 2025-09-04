//
//  ExpandingButton.swift
//  HitTips
//
//  Created by Matt Martindale on 9/3/25.
//  Copyright © 2025 Matthew Martindale. All rights reserved.
//

import UIKit

final class ExpandingButton: UIView {
    
    // MARK: - Properties
    
    private var isExpanded = false
    
    private let buttonSize: CGFloat = 30
    let expandedHeight: CGFloat = 200
    let expandedWidth: CGFloat = 200
    
    private var expandedWidthConstraint: NSLayoutConstraint!
    private var expandedHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Subviews
    
    private lazy var expandingContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var expandedView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = buttonSize / 2
        view.alpha = 0
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var mainButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = buttonSize / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleExpansion), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alpha = 0
        return stackView
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        addExpandedButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup and Layout
    
    private func setupViews() {
        addSubview(expandingContainerView)
        expandingContainerView.addSubview(expandedView)
        expandingContainerView.addSubview(mainButton)
        expandedView.addSubview(buttonStackView)
        
        expandingContainerView.bringSubviewToFront(mainButton)
        
        NSLayoutConstraint.activate([
            expandingContainerView.topAnchor.constraint(equalTo: topAnchor),
            expandingContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            expandingContainerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            expandingContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Main button at the top, expanded area grows below
            mainButton.trailingAnchor.constraint(equalTo: expandingContainerView.trailingAnchor),
            mainButton.topAnchor.constraint(equalTo: expandingContainerView.topAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: buttonSize),
            mainButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            // Expanded view attaches to the bottom of the main button
            expandedView.topAnchor.constraint(equalTo: mainButton.centerYAnchor),
            expandedView.trailingAnchor.constraint(equalTo: mainButton.centerXAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: expandedView.topAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: expandedView.leadingAnchor, constant: 20),
            buttonStackView.trailingAnchor.constraint(equalTo: expandedView.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: expandedView.bottomAnchor, constant: -20)
        ])
        
        expandedWidthConstraint = expandedView.widthAnchor.constraint(equalToConstant: buttonSize)
        expandedHeightConstraint = expandedView.heightAnchor.constraint(equalToConstant: buttonSize)
        NSLayoutConstraint.activate([expandedWidthConstraint, expandedHeightConstraint])
    }
    
    // MARK: - Sub-button Management
    
    private func addExpandedButtons() {
        let option1 = createButton(title: "Option 1", action: #selector(option1Tapped))
        let option2 = createButton(title: "Option 2", action: #selector(option2Tapped))
        let option3 = createButton(title: "Option 3", action: #selector(option3Tapped))
        
        buttonStackView.addArrangedSubview(option1)
        buttonStackView.addArrangedSubview(option2)
        buttonStackView.addArrangedSubview(option3)
    }
    
    private func createButton(title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
    
    @objc private func option1Tapped() {
        print("Option 1 tapped!")
        toggleExpansion()
    }
    
    @objc private func option2Tapped() {
        print("Option 2 tapped!")
        toggleExpansion()
    }
    
    @objc private func option3Tapped() {
        print("Option 3 tapped!")
        toggleExpansion()
    }
    
    // MARK: - Animation
    
    @objc private func toggleExpansion() {
        isExpanded.toggle()
        mainButton.isUserInteractionEnabled = false
        
        expandedWidthConstraint.constant = isExpanded ? expandedWidth : buttonSize
        expandedHeightConstraint.constant = isExpanded ? expandedHeight : buttonSize
        
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: {
                self.layoutIfNeeded()
                self.expandedView.alpha = self.isExpanded ? 1 : 0
                self.mainButton.transform = self.isExpanded
                ? CGAffineTransform(rotationAngle: .pi / 4)
                : .identity
                if self.isExpanded {
                    self.expandedView.layer.cornerRadius = 20
                    self.expandedView.layer.maskedCorners = [
                        .layerMinXMinYCorner,  // top-left
                        .layerMinXMaxYCorner,  // bottom-left
                        .layerMaxXMaxYCorner   // bottom-right
                    ]
                } else {
                    self.expandedView.layer.cornerRadius = self.buttonSize / 2
                    self.expandedView.layer.maskedCorners = [
                        .layerMinXMinYCorner,
                        .layerMaxXMinYCorner,
                        .layerMinXMaxYCorner,
                        .layerMaxXMaxYCorner
                    ] // reset to all
                }
            }, completion: { _ in
                self.mainButton.isUserInteractionEnabled = true
            }
        )
        self.buttonStackView.alpha = self.isExpanded ? 1 : 0
    }
}
