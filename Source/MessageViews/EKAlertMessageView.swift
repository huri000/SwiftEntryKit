//
//  EKAlertMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/5/18.
//

import UIKit

final public class EKAlertMessageView: EKSimpleMessageView, EntryAppearanceDescriptor {
    
    // MARK: Props
    var buttonBarView: EKButtonBarView!
    private var buttonsBarCompressedConstraint: NSLayoutConstraint!
    private var buttonsBarExpandedConstraint: NSLayoutConstraint!
    
    // MARK: EntryAppearenceDescriptor
    
    var bottomCornerRadius: CGFloat = 0 {
        didSet {
            buttonBarView.bottomCornerRadius = bottomCornerRadius
        }
    }
    
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
            
            if let thumbImageView = thumbImageView {
                thumbImageView.layoutToSuperview(.top, offset: 20)
                thumbImageView.layoutToSuperview(.centerX)
                messageContentView.layout(.top, to: .bottom, of: thumbImageView)
            } else {
                messageContentView.layoutToSuperview(.top)
            }

            messageContentView.layoutToSuperview(axis: .horizontally)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView)
        case .left:
            messageContentView.verticalMargins = 0
            messageContentView.horizontalMargins = 0
            messageContentView.labelsOffset = 5
            
            if let thumbImageView = thumbImageView {
                thumbImageView.layoutToSuperview(.top, .left, offset: 16)
                messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
                messageContentView.layout(to: .top, of: thumbImageView, offset: 2)
            } else {
                messageContentView.layoutToSuperview(.left, .top, offset: 16)
            }

            messageContentView.layoutToSuperview(.right, offset: -16)
            buttonBarView.layout(.top, to: .bottom, of: messageContentView, offset: 10)
        }
        
        buttonBarView.layoutToSuperview(axis: .horizontally)
        buttonBarView.layoutToSuperview(.bottom)
        buttonBarView.alpha = 0

        if !message.buttonBarContent.content.isEmpty {
            if message.buttonBarContent.expandAnimatedly {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.buttonBarView.expand()
                }
            } else {
                buttonBarView.expand()
            }
        }
    }
}
