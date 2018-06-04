//
//  EKMessageView.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/5/18.
//

import UIKit

public class EKSimpleMessageView: UIView {

    // MARK: Props
    var thumbImageView: UIImageView!
    let messageContentView = EKMessageContentView()
    
    // MARK: Setup
    init(with message: EKSimpleMessage) {
        super.init(frame: UIScreen.main.bounds)
        setupThumbImageView(with: message.image)
        setupMessageContentView(with: message.title, description: message.description)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupThumbImageView(with content: EKProperty.ImageContent?) {
        guard let content = content else {
            return
        }
        thumbImageView = UIImageView()
        addSubview(thumbImageView)
        thumbImageView.imageContent = content
    }
    
    private func setupMessageContentView(with title: EKProperty.LabelContent, description: EKProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        addSubview(messageContentView)
    }    
}
