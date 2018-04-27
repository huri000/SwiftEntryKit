//
//  EKNotificationMessage.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/20/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKNotificationMessage {    
    public let title: EKProperty.LabelContent
    public let description: EKProperty.LabelContent
    public let time: EKProperty.LabelContent
    public let image: UIImage
    public let roundImage: Bool
    
    public init(title: EKProperty.LabelContent, description: EKProperty.LabelContent, time: EKProperty.LabelContent, image: UIImage, roundImage: Bool) {
        self.title = title
        self.description = description
        self.time = time
        self.image = image
        self.roundImage = roundImage
    }
}
