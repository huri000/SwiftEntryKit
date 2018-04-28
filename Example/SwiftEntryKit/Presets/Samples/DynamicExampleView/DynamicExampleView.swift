//
//  DynamicExampleView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import QuickLayout
import SwiftEntryKit

class DynamicExampleView: UIView {
    
    private var notificationMessageView: EKNotificationMessageView!
    private let buttonsBarView = ButtonsBarView()
    
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    init(with message: EKNotificationMessage, buttonsContent: ButtonsBarContent) {
        super.init(frame: UIScreen.main.bounds)
        setupNotificationMessageView(withContent: message)
        setupButtonsBarView(withContent: buttonsContent)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNotificationMessageView(withContent content: EKNotificationMessage) {
        notificationMessageView = EKNotificationMessageView(with: content)
        addSubview(notificationMessageView)
        notificationMessageView.layoutToSuperview(.left, .right, .top)
    }
    
    private func setupButtonsBarView(withContent content: ButtonsBarContent) {
        buttonsBarView.clipsToBounds = true
        addSubview(buttonsBarView)
        buttonsBarView.layoutToSuperview(axis: .horizontally)
        buttonsBarView.layoutToSuperview(.bottom)
        buttonsBarView.layout(.top, to: .bottom, of: notificationMessageView)
        buttonsBarCompressedConstraint = buttonsBarView.set(.height, of: 1, priority: .must)
        buttonsBarExpandedConstraint = buttonsBarView.set(.height, of: 50, priority: .defaultLow)

        buttonsBarView.buttonsContent = content
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animateIn()
        }
    }
    
    private func animateIn() {
        layoutIfNeeded()
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
            self.buttonsBarCompressedConstraint.priority = .defaultLow
            self.buttonsBarExpandedConstraint.priority = .must
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
