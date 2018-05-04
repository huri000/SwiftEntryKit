//
//  EKNotificationMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public class EKNotificationMessageView: UIView {
    
    // MARK: Props
    private let thumbImageView = UIImageView()
    private let messageContentView = EKMessageContentView()
    private let auxLabel = UILabel()
    
    private let message: EKNotificationMessage
    
    // MARK: Setup
    public init(with message: EKNotificationMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupThumbImageView(with: message.image)
        setupAuxLabel(with: message.auxiliary)
        setupMessageContentView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupThumbImageView(with content: EKProperty.ImageContent) {
        addSubview(thumbImageView)
        thumbImageView.imageContent = content
        thumbImageView.layoutToSuperview(.top, .left, offset: 16)
    }
    
    private func setupAuxLabel(with content: EKProperty.LabelContent?) {
        if let content = content {
            auxLabel.labelContent = content
        }
        addSubview(auxLabel)
        auxLabel.layoutToSuperview(.right, offset: -16)
        auxLabel.layoutToSuperview(.top, offset: 18)
        auxLabel.forceContentWrap()
    }
    
    private func setupMessageContentView() {
        messageContentView.verticalMargins = 0
        messageContentView.horizontalMargins = 0
        messageContentView.labelsOffset = 5
        messageContentView.titleContent = message.title
        messageContentView.subtitleContent = message.description
        addSubview(messageContentView)
        messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
        messageContentView.layout(.right, to: .left, of: auxLabel)
        messageContentView.layout(to: .top, of: thumbImageView, offset: 4)
        messageContentView.layoutToSuperview(.bottom, offset: -20)
    }
}
