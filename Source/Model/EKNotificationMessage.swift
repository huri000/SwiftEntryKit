//
//  EKNotificationMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKNotificationMessage {
    
    public struct Margins {
        public var edgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        public var titleToDescription: CGFloat = 5
        
        public static var `default` = Margins()
    }
    
    /** Image, Title, Description */
    public let simpleMessage: EKSimpleMessage
    
    /** Optional auxiliary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: EKProperty.LabelContent?
    
    /** Defines the vertical and horizontal margins */
    public let margins: Margins
    
    public init(simpleMessage: EKSimpleMessage, auxiliary: EKProperty.LabelContent? = nil, margins: Margins = .default) {
        self.simpleMessage = simpleMessage
        self.auxiliary = auxiliary
        self.margins = margins
    }
}
