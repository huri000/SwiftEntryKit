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
        
        public struct Gradient {
            public let colors: [UIColor]
            public let startPoint: CGPoint
            public let endPoint: CGPoint
            
            public init(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
                self.colors = colors
                self.startPoint = startPoint
                self.endPoint = endPoint
            }
        }
        
        case visualEffect(style: UIBlurEffectStyle)
        case color(color: UIColor)
        case gradient(gradient: Gradient)
        case image(image: UIImage)
        case clear
    }
}
