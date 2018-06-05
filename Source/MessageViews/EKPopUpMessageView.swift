//
//  EKPopUpMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKPopUpMessageView: UIView {

    // MARK: Props
    private var imageView: UIImageView!
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let actionButton = UIButton()
    
    private let message: EKPopUpMessage
    
    // MARK: Setup
    public init(with message: EKPopUpMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
        setupActionButton()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        guard let themeImage = message.themeImage else {
            return
        }
        imageView = UIImageView()
        addSubview(imageView)
        imageView.layoutToSuperview(.centerX)
        switch themeImage.position {
        case .centerToTop(offset: let value):
            imageView.layout(.centerY, to: .top, of: self, offset: value)
        case .topToTop(offset: let value):
            imageView.layoutToSuperview(.top, offset: value)
        }
        imageView.imageContent = themeImage.image
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.content = message.title
        titleLabel.layoutToSuperview(axis: .horizontally, offset: 30)
        if let imageView = imageView {
            titleLabel.layout(.top, to: .bottom, of: imageView, offset: 20)
        } else {
            titleLabel.layoutToSuperview(.top, offset: 20)
        }
        titleLabel.forceContentWrap(.vertically)
    }
    
    private func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.content = message.description
        descriptionLabel.layoutToSuperview(axis: .horizontally, offset: 30)
        descriptionLabel.layout(.top, to: .bottom, of: titleLabel, offset: 16)
        descriptionLabel.forceContentWrap(.vertically)
    }
    
    private func setupActionButton() {
        addSubview(actionButton)
        let height: CGFloat = 45
        actionButton.set(.height, of: height)
        actionButton.layout(.top, to: .bottom, of: descriptionLabel, offset: 30)
        actionButton.layoutToSuperview(.bottom, offset: -30)
        actionButton.layoutToSuperview(.centerX)
        
        let buttonAttributes = message.button
        actionButton.buttonContent = buttonAttributes
        actionButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        actionButton.layer.cornerRadius = height * 0.5
        actionButton.addTarget(self, action: #selector(actionButtonPressed), for: .touchUpInside)
        
        let tapColor = buttonAttributes.label.style.color.withAlphaComponent(0.8)
        actionButton.setTitleColor(tapColor, for: .highlighted)
        actionButton.setTitleColor(tapColor, for: .selected)
    }
    
    @objc func actionButtonPressed() {
        message.action()
    }
}
