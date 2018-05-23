//
//  EKNotificationMessageToastView.swift
//  SwiftEntryKit
//
//  Created by Pooja Gupta on 5/23/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKNotificationMessageToastView: EKMessageToastView {
    
    // MARK: Props
    private let auxLabel = UILabel()
    
    // MARK: Setup
    public init(with message: EKNotificationMessageWithoutImage) {
        super.init(with: message.messageToast)
        setupAuxLabel(with: message.auxiliary)
        layoutContent()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAuxLabel(with content: EKProperty.LabelContent?) {
        if let content = content {
            auxLabel.labelContent = content
        }
        addSubview(auxLabel)
    }
    
    private func layoutContent() {
        
        messageContentView.verticalMargins = 0
        messageContentView.horizontalMargins = 0
        messageContentView.labelsOffset = 5
        
        auxLabel.layoutToSuperview(.right, offset: -16)
        auxLabel.layoutToSuperview(.top, offset: 18)
        auxLabel.forceContentWrap()
        
        messageContentView.layoutToSuperview(.left, offset: 16)
        messageContentView.layout(.right, to: .left, of: auxLabel)
        messageContentView.layoutToSuperview(.bottom, offset: -20)
        messageContentView.layoutToSuperview(.top, offset: 10)
    }
}
