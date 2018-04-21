//
//  EntryTableViewCell.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit
import QuickLayout
import UIKit

class EntryTableViewCell: UITableViewCell {

    // MARK: Props
    private let messageContentView = EKMessageContentView()
    
    var message: Message! {
        didSet {
            messageContentView.title = message.title
            messageContentView.subtitle = message.subtitle
        }
    }
    
    // MARK: Setup
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(messageContentView)
        messageContentView.titleAttributes = EKProperty.Label(font: UIFont.boldSystemFont(ofSize: 18), color: .black)
        messageContentView.subtitleAttributes = EKProperty.Label(font: UIFont.systemFont(ofSize: 14), color: .black)
        messageContentView.fillSuperview()
    }
}
