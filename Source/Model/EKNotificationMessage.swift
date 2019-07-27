//
//  EKNotificationMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKNotificationMessage {
    
    /** Insets of the content of the message */
    public struct Insets {
        
        /** The insets of the content of the message, from the top, bottom, left, right */
        public var contentInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        /** The distance between the title and the description */
        public var titleToDescription: CGFloat = 5
        
        public static var `default` = Insets()
    }
    
    /** Image, Title, Description */
    public let simpleMessage: EKSimpleMessage
    
    /** Optional auxiliary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: EKProperty.LabelContent?
    
    /** Defines the vertical and horizontal margins */
    public let insets: Insets
        
    public init(simpleMessage: EKSimpleMessage,
                auxiliary: EKProperty.LabelContent? = nil,
                insets: Insets = .default) {
        self.simpleMessage = simpleMessage
        self.auxiliary = auxiliary
        self.insets = insets
    }
}
