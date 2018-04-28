//
//  EKPopUpMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKPopUpMessage {
    
    public typealias EKPopUpMessageAction = () -> ()
    
    public var title: EKProperty.LabelContent
    public var description: EKProperty.LabelContent
    public var button: EKProperty.ButtonContent
    public var image: UIImage
    public var action: EKPopUpMessageAction
    
    public init(title: EKProperty.LabelContent, description: EKProperty.LabelContent, button: EKProperty.ButtonContent, image: UIImage, action: @escaping EKPopUpMessageAction) {
        self.title = title
        self.description = description
        self.button = button
        self.image = image
        self.action = action
    }
}
