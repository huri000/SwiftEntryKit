//
//  EKNotificationMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKNotificationMessageView: EKSimpleMessageView {
    
    // MARK: Props
    private var auxLabel: UILabel!
    
    // MARK: Setup
    public init(with message: EKNotificationMessage) {
        super.init(with: message.simpleMessage)
        setupAuxLabel(with: message.auxiliary)
        layoutContent(with: message.insets)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAuxLabel(with content: EKProperty.LabelContent?) {
        guard let content = content else {
            return
        }
        auxLabel = UILabel()
        auxLabel.content = content
        addSubview(auxLabel)
    }
    
    private func layoutContent(with insets: EKNotificationMessage.Insets) {
        
        messageContentView.verticalMargins = 0
        messageContentView.horizontalMargins = 0
        messageContentView.labelsOffset = insets.titleToDescription
        
        if let thumbImageView = thumbImageView {
            thumbImageView.layoutToSuperview(.left, offset: insets.contentInsets.left)
            thumbImageView.layoutToSuperview(.top, offset: insets.contentInsets.top)
            messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
            messageContentView.layout(to: .top, of: thumbImageView, offset: 4)
        } else {
            messageContentView.layoutToSuperview(.left, offset: insets.contentInsets.left)
            messageContentView.layoutToSuperview(.top, offset: insets.contentInsets.top)
        }

        if let auxLabel = auxLabel {
            auxLabel.layoutToSuperview(.right, offset: -insets.contentInsets.right)
            auxLabel.layoutToSuperview(.top, offset: insets.contentInsets.top + 2)
            auxLabel.forceContentWrap()
            messageContentView.layout(.right, to: .left, of: auxLabel)
        } else {
            messageContentView.layoutToSuperview(.right, offset: -insets.contentInsets.right)
        }
        messageContentView.layoutToSuperview(.bottom, offset: -insets.contentInsets.bottom)
    }
}
