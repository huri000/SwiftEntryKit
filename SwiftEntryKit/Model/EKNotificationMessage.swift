//
//  EKNotificationMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKSimpleMessage {
    
    /** The image view descriptor */
    public let image: EKProperty.ImageContent
    
    /** The title label descriptor */
    public let title: EKProperty.LabelContent
    
    /** The description label descriptor */
    public let description: EKProperty.LabelContent
    
    public init(image: EKProperty.ImageContent, title: EKProperty.LabelContent, description: EKProperty.LabelContent) {
        self.image = image
        self.title = title
        self.description = description
    }
}

public struct EKNotificationMessage {
    
    /** Image, Title, Description */
    public let simpleMessage: EKSimpleMessage
    
    /** Optional auxilary label descriptor (For instance, it be used to display time of message) */
    public let auxiliary: EKProperty.LabelContent?
    
    public init(simpleMessage: EKSimpleMessage, auxiliary: EKProperty.LabelContent? = nil) {
        self.simpleMessage = simpleMessage
        self.auxiliary = auxiliary
    }
}

public struct EKAlertMessage {
    
    public enum ImagePosition {
        case top
        case left
    }
    
    /** The position of the image inside the alert */
    public let imagePosition: ImagePosition
    
    /** Image, Title, Description */
    public let simpleMessage: EKSimpleMessage
    
    /** Contents of button bar */
    public let buttonBarContent: EKProperty.ButtonBarContent
        
    public init(simpleMessage: EKSimpleMessage, imagePosition: ImagePosition = .top, buttonBarContent: EKProperty.ButtonBarContent) {
        self.simpleMessage = simpleMessage
        self.imagePosition = imagePosition
        self.buttonBarContent = buttonBarContent
    }
}
