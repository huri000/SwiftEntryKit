//
//  EKAlertMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/5/18.
//

import UIKit

public class EKAlertMessageView: EKSimpleMessageView {
    
    // MARK: Props
    private var buttonBarView: EKButtonBarView!
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    // MARK: Setup
    public init(with message: EKAlertMessage) {
        super.init(with: message.simpleMessage)
        setupButtonBarView(with: message.buttonBarContent)
        layoutContent(with: message)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButtonBarView(with content: EKProperty.ButtonBarContent) {
        buttonBarView = EKButtonBarView(with: content)
        buttonBarView.clipsToBounds = true
        addSubview(buttonBarView)
    }
    
    func layoutContent(with message: EKAlertMessage) {

        switch message.imagePosition {
        case .top:
            messageContentView.verticalMargins = 16
            messageContentView.horizontalMargins = 16
            messageContentView.labelsOffset = 5
            
            thumbImageView.layoutToSuperview(.top, offset: 20)
            thumbImageView.layoutToSuperview(.centerX)
            
            messageContentView.layout(.top, to: .bottom, of: thumbImageView)
            messageContentView.layoutToSuperview(axis: .horizontally)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView)
        case .left:
            messageContentView.verticalMargins = 0
            messageContentView.horizontalMargins = 0
            messageContentView.labelsOffset = 5
            
            thumbImageView.layoutToSuperview(.top, .left, offset: 16)

            messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
            messageContentView.layoutToSuperview(.right, offset: -16)
            messageContentView.layout(to: .top, of: thumbImageView, offset: 2)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
        }
        
        buttonBarView.layoutToSuperview(axis: .horizontally)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.alpha = 0

        if !message.buttonBarContent.content.isEmpty {
            if message.buttonBarContent.expandAnimatedly {
                let damping: CGFloat = message.buttonBarContent.content.count <= 2 ? 0.4 : 0.8
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animateIn(damping: damping)
                }
            } else {
                buttonBarView.alpha = 1
                buttonBarView.expand()
                SwiftEntryKit.layoutIfNeeded()
            }
        }
    }
    
    // MARK: Internal Animation
    private func animateIn(damping: CGFloat) {
        layoutIfNeeded()
        buttonBarView.alpha = 1
        
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: damping, initialSpringVelocity: 0, options: [.beginFromCurrentState, .allowUserInteraction, .layoutSubviews], animations: {
            
            // Expand
            self.buttonBarView.expand()
            
            /* NOTE: Calling layoutIfNeeded for the whole view hierarchy.
             Sometimes it's easier to just use frames instead of AutoLayout for
             hierarch complexity considerations. Here the animation influences almost the
             entire view hierarchy. */
            SwiftEntryKit.layoutIfNeeded()
            
        }, completion: nil)
    }
}
