//
//  EKNotificationMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

public struct EKNotificationMessage {
    
    /** Image, Title, Description */
    public let simpleMessage: EKSimpleMessage
    
    /** Optional auxiliary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: EKProperty.LabelContent?
    
    public init(simpleMessage: EKSimpleMessage, auxiliary: EKProperty.LabelContent? = nil) {
        self.simpleMessage = simpleMessage
        self.auxiliary = auxiliary
    }
}
