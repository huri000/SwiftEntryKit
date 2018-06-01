//
//  EKSimpleMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

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
