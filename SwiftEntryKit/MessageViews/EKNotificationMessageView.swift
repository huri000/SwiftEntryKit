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
        thumbImageView.contentMode = .scaleToFill
        thumbImageView.image = message.image
        thumbImageView.layoutToSuperview(.top, .left, offset: 16)

        let edge: CGFloat = 50
        thumbImageView.set(.width, .height, of: edge)
        if message.roundImage {
            thumbImageView.clipsToBounds = true
            thumbImageView.layer.cornerRadius = edge * 0.5
        }
    }
    
    private func setupTimeLabel() {
        timeLabel.labelContent = message.time
        addSubview(timeLabel)
        timeLabel.layoutToSuperview(.right, offset: -16)
        timeLabel.layoutToSuperview(.top, offset: 18)
        timeLabel.forceContentWrap()
    }
    
    private func setupMessageContentView() {
        messageContentView.verticalMargins = 0
        messageContentView.horizontalMargins = 0
        messageContentView.labelsOffset = 5
        messageContentView.titleContent = message.title
        messageContentView.subtitleContent = message.description
        addSubview(messageContentView)
        messageContentView.layout(.left, to: .right, of: thumbImageView, offset: 12)
        messageContentView.layout(.right, to: .left, of: timeLabel)
        messageContentView.layout(to: .top, of: thumbImageView, offset: 4)
        messageContentView.layoutToSuperview(.bottom, offset: -20)
    }
}
