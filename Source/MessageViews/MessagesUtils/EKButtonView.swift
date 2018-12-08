//
//  EKButtonView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 12/8/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class EKButtonView: UIView {

    // MARK: - Properties
    
    private let button = UIButton()
    private let titleLabel = UILabel()
    
    private let content: EKProperty.ButtonContent
    
    // MARK: - Setup
    
    init(content: EKProperty.ButtonContent) {
        self.content = content
        super.init(frame: .zero)
        setupTitleLabel()
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        addSubview(button)
        button.fillSuperview()
        button.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        button.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
    }
    
    private func setupTitleLabel() {
        titleLabel.numberOfLines = content.label.style.numberOfLines
        titleLabel.font = content.label.style.font
        titleLabel.textColor = content.label.style.color
        titleLabel.text = content.label.text
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byWordWrapping
        backgroundColor = content.backgroundColor
        addSubview(titleLabel)
        titleLabel.layoutToSuperview(axis: .horizontally, offset: content.contentEdgeInset)
        titleLabel.layoutToSuperview(axis: .vertically, offset: content.contentEdgeInset)
    }
    
    private func setBackground(by content: EKProperty.ButtonContent, isHighlighted: Bool) {
        if isHighlighted {
            backgroundColor = content.highlightedBackgroundColor
        } else {
            backgroundColor = content.backgroundColor
        }
    }
    
    // MARK: - Selectors
    
    @objc func buttonTouchUpInside() {
        content.action?()
    }
    
    @objc func buttonTouchDown() {
        setBackground(by: content, isHighlighted: true)
    }
    
    @objc func buttonTouchUp() {
        setBackground(by: content, isHighlighted: false)
    }
}
