//
//  EKPopUpMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKPopUpMessage {
    
    /** Code block that is executed as the user taps the popup button */
    public typealias EKPopUpMessageAction = () -> ()
    
    /** Position of the top image */
    public enum ImagePosition {
        case topToTop(offset: CGFloat)
        case centerToTop(offset: CGFloat)
    }
    
    public var title: EKProperty.LabelContent
    public var description: EKProperty.LabelContent
    public var button: EKProperty.ButtonContent
    public var topImage: EKProperty.ImageContent
    public var imagePosition: ImagePosition
    public var action: EKPopUpMessageAction
    
    public init(topImage: EKProperty.ImageContent, imagePosition: ImagePosition = .topToTop(offset: 40), title: EKProperty.LabelContent, description: EKProperty.LabelContent, button: EKProperty.ButtonContent, action: @escaping EKPopUpMessageAction) {
        self.topImage = topImage
        self.imagePosition = imagePosition
        self.title = title
        self.description = description
        self.button = button
        self.action = action
    }
}
