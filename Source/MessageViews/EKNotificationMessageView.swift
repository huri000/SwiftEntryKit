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
        layoutContent(with: message.margins)
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
    
    private func layoutContent(with margins: EKNotificationMessage.Margins) {
        
        messageContentView.verticalMargins = 0
        messageContentView.horizontalMargins = 0
        messageContentView.labelsOffset = margins.titleToDescription
        
        if let thumbImageView = thumbImageView {
            thumbImageView.layoutToSuperview(.left, offset: margins.edgeInsets.left)
            thumbImageView.layoutToSuperview(.top, offset: margins.edgeInsets.top)
            messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
            messageContentView.layout(to: .top, of: thumbImageView, offset: 4)
        } else {
            messageContentView.layoutToSuperview(.left, offset: margins.edgeInsets.left)
            messageContentView.layoutToSuperview(.top, offset: margins.edgeInsets.top)
        }

        if let auxLabel = auxLabel {
            auxLabel.layoutToSuperview(.right, offset: -margins.edgeInsets.right)
            auxLabel.layoutToSuperview(.top, offset: margins.edgeInsets.top + 2)
            auxLabel.forceContentWrap()
            messageContentView.layout(.right, to: .left, of: auxLabel)
        } else {
            messageContentView.layoutToSuperview(.right, offset: -margins.edgeInsets.right)
        }
        messageContentView.layoutToSuperview(.bottom, offset: -margins.edgeInsets.bottom)
    }
}
