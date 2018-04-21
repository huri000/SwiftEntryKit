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
    private let timeLabel = UILabel()
    private let messageContentView = EKMessageContentView()
    
    private let message: EKNotificationMessage
    
    // MARK: Setup
    public init(with message: EKNotificationMessage) {
        self.message = message
        super.init(frame: UIScreen.main.bounds)
        setupThumbImageView()
        setupTimeLabel()
        setupMessageContentView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupThumbImageView() {
        addSubview(thumbImageView)
        thumbImageView.image = message.image
        thumbImageView.layoutToSuperview(.top, .left, offset: 16)
        thumbImageView.forceContentWrap()
    }
    
    private func setupTimeLabel() {
        timeLabel.labelContent = message.time
        addSubview(timeLabel)
        timeLabel.layoutToSuperview(.right, offset: -16)
        timeLabel.layoutToSuperview(.top, offset: 16)
        timeLabel.forceContentWrap()
    }
    
    private func setupMessageContentView() {
        messageContentView.verticalMargins = 16
        messageContentView.titleContent
            = message.title
        messageContentView.subtitleContent = message.description
        addSubview(messageContentView)
        messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 8)
        messageContentView.layout(.right, to: .left, of: timeLabel, offset: -8)
        messageContentView.layoutToSuperview(.bottom, .top)
    }
}
