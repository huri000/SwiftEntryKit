//
//  DynamicExampleView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout
import SwiftEntryKit

class DynamicExampleView: UIView {
        
    private var notificationMessageView: EKNotificationMessageView!
    private let buttonsBarView = ButtonsBarView()
    
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    init(with message: EKNotificationMessage, buttonsContent: ButtonsBarContent, approveAction: @escaping ButtonsBarView.Action) {
        super.init(frame: UIScreen.main.bounds)
        setupNotificationMessageView(withContent: message)
        setupButtonsBarView(withContent: buttonsContent, approveAction: approveAction)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNotificationMessageView(withContent content: EKNotificationMessage) {
        notificationMessageView = EKNotificationMessageView(with: content)
        addSubview(notificationMessageView)
        notificationMessageView.layoutToSuperview(.left, .right, .top)
    }
    
    private func setupButtonsBarView(withContent content: ButtonsBarContent, approveAction: @escaping ButtonsBarView.Action) {
        buttonsBarView.clipsToBounds = true
        addSubview(buttonsBarView)
        buttonsBarView.layoutToSuperview(axis: .horizontally)
        buttonsBarView.layoutToSuperview(.bottom)
        buttonsBarView.layout(.top, to: .bottom, of: notificationMessageView)
        buttonsBarCompressedConstraint = buttonsBarView.set(.height, of: 1, priority: .must)
        buttonsBarExpandedConstraint = buttonsBarView.set(.height, of: 50, priority: .defaultLow)
        
        buttonsBarView.approveAction = approveAction
        buttonsBarView.buttonsContent = content
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animateIn()
        }
    }
    
    private func animateIn() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction, .layoutSubviews], animations: {
            
            self.buttonsBarCompressedConstraint.priority = .defaultLow
            self.buttonsBarExpandedConstraint.priority = .must
            
            /* NOTE: Calling layoutIfNeeded for the whole view hierarchy.
             Sometimes it's easier to just use frames instead of AutoLayout for
             hierarch complexity considerations. Here the animation influences almost the
             entire view hierarchy. */
            SwiftEntryKit.layoutIfNeeded()
            
        }, completion: nil)
    }
}
