//
//  EKRatingMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/1/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

public class EKRatingMessageView: UIView {
    
    private var message: EKRatingMessage

    private var selectedIndex: Int! {
        didSet {
            message.selectedIndex = selectedIndex
            let item = message.ratingItems[selectedIndex]
            set(title: item.title, description: item.description)
        }
    }
    
    private let messageContentView = EKMessageContentView()
    private let symbolsView = EKRatingSymbolsContainerView()
    private var buttonBarView: EKButtonBarView!

    public init(with message: EKRatingMessage) {
        self.message = message
        super.init(frame: .zero)
        setupMessageContentView()
        setupSymbolsView()
        setupButtonBarView()
        set(title: message.initialTitle, description: message.initialDescription)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func set(title: EKProperty.LabelContent, description: EKProperty.LabelContent) {
        self.messageContentView.titleContent = title
        self.messageContentView.subtitleContent = description
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: [.transitionCrossDissolve], animations: {
            SwiftEntryKit.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupMessageContentView() {
        addSubview(messageContentView)
        messageContentView.verticalMargins = 20
        messageContentView.horizontalMargins = 30
        messageContentView.layoutToSuperview(axis: .horizontally)
        messageContentView.layoutToSuperview(.top, offset: 10)
    }
    
    private func setupSymbolsView() {
        addSubview(symbolsView)
        symbolsView.setup(with: message) { [unowned self] (index: Int) in
            self.message.selectedIndex = index
            self.message.selection?(index)
            self.selectedIndex = index
            self.animateIn()
        }
        symbolsView.layoutToSuperview(.centerX)
        symbolsView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
    }

    private func setupButtonBarView() {
        buttonBarView = EKButtonBarView(with: message.buttonBarContent)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
        buttonBarView.layout(.top, to: .bottom, of: symbolsView, offset: 30)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layoutToSuperview(axis: .horizontally)
    }
    
    // MARK: Internal Animation
    private func animateIn() {
        layoutIfNeeded()
        buttonBarView.alpha = 1
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction, .layoutSubviews], animations: {
            self.buttonBarView.expand()
            SwiftEntryKit.layoutIfNeeded()
        }, completion: nil)
    }
}
