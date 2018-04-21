//
//  EKAttributes+BackgroundStyle.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    public enum BackgroundStyle {
        case visualEffect(style: UIBlurEffectStyle)
        case color(color: UIColor)
        case image(image: UIImage)
        case none
    }
}
