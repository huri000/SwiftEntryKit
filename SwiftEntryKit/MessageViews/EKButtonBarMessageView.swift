//
//  EKButtonBarMessageView.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

public class EKButtonBarMessageView: UIView {
    
    // MARK: Props
    private var notificationMessageView: EKNotificationMessageView!
    private var buttonBarView: EKButtonBarView!
    
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    // MARK: Setup
    public init(with message: EKNotificationMessage, buttonsContent: EKProperty.ButtonBarContent) {
        super.init(frame: UIScreen.main.bounds)
        setupNotificationMessageView(withContent: message)
        setupButtonsBarView(withContent: buttonsContent)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNotificationMessageView(withContent content: EKNotificationMessage) {
        notificationMessageView = EKNotificationMessageView(with: content)
        addSubview(notificationMessageView)
        notificationMessageView.layoutToSuperview(.left, .right, .top)
    }
    
    private func setupButtonsBarView(withContent content: EKProperty.ButtonBarContent) {
        buttonBarView = EKButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
        buttonBarView.layoutToSuperview(axis: .horizontally)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.layout(.top, to: .bottom, of: notificationMessageView)
        buttonsBarCompressedConstraint = buttonBarView.set(.height, of: 1, priority: .must)
        
        let buttonHeight: CGFloat = 50
        let height: CGFloat
        switch content.content.count {
        case 0:
            height = 1
        case 1, 2:
            height = buttonHeight
        default:
            height = buttonHeight * CGFloat(content.content.count)
        }
        
        buttonsBarExpandedConstraint = buttonBarView.set(.height, of: height, priority: .defaultLow)
        buttonBarView.alpha = 0
        
        if !content.content.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.animateIn()
            }
        }
    }
    
    // MARK: Internal Animation
    
    private func animateIn() {
        buttonBarView.alpha = 1
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
