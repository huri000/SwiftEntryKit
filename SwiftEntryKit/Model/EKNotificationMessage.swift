//
//  EKNotificationMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKNotificationMessage {
    
    /** The image view descriptor */
    public let image: EKProperty.ImageContent
    
    /** The title label descriptor */
    public let title: EKProperty.LabelContent
    
    /** The description label descriptor */
    public let description: EKProperty.LabelContent
    
    /** Optional auxilary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: EKProperty.LabelContent?
    
    public init(image: EKProperty.ImageContent, title: EKProperty.LabelContent, description: EKProperty.LabelContent, auxiliary: EKProperty.LabelContent? = nil) {
        self.image = image
        self.title = title
        self.description = description
        self.auxiliary = auxiliary
    }
}
