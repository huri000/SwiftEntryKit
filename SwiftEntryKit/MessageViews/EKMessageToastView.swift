//
//  EKMessageView.swift
//  SwiftEntryKit
//
//  Created by Pooja Gupta on 23/5/18.
//

import UIKit

public class EKMessageToastView: UIView {

    // MARK: Props
    let messageContentView = EKMessageContentView()
    
    // MARK: Setup
    init(with message: EKMessageToast) {
        super.init(frame: UIScreen.main.bounds)
        setupMessageContentView(with: message.title, description: message.description)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMessageContentView(with title: EKProperty.LabelContent, description: EKProperty.LabelContent) {
        messageContentView.titleContent = title
        messageContentView.subtitleContent = description
        addSubview(messageContentView)
    }    
}
