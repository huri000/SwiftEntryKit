//
//  EKAttributes+BackgroundStyle.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    /** The background style property */
    public enum BackgroundStyle: Equatable {
        
        /** Gradient background style */
        public struct Gradient {
            public var colors: [UIColor]
            public var startPoint: CGPoint
            public var endPoint: CGPoint
            
            public init(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
                self.colors = colors
                self.startPoint = startPoint
                self.endPoint = endPoint
            }
        }
        
        /** Visual Effect (Blurred) background style */
        case visualEffect(style: UIBlurEffect.Style)
        
        /** Color background style */
        case color(color: UIColor)
        
        /** Gradient background style */
        case gradient(gradient: Gradient)
        
        /** Image background style */
        case image(image: UIImage)
        
        /** Clear background style */
        case clear
        
        /** == operator overload */
        public static func == (lhs: EKAttributes.BackgroundStyle, rhs: EKAttributes.BackgroundStyle) -> Bool {
            switch (lhs, rhs) {
            case (visualEffect(style: let leftStyle), visualEffect(style: let rightStyle)):
                return leftStyle == rightStyle
            case (color(color: let leftColor), color(color: let rightColor)):
                return leftColor == rightColor
            case (image(image: let leftImage), image(image: let rightImage)):
                return leftImage == rightImage
            case (gradient(gradient: let leftGradient), gradient(gradient: let rightGradient)):
                for (leftColor, rightColor) in zip(leftGradient.colors, rightGradient.colors) {
                    guard leftColor == rightColor else {
                        return false
                    }
                }
                return leftGradient.startPoint == rightGradient.startPoint && leftGradient.endPoint == rightGradient.endPoint
            case (clear, clear):
                return true
            default:
                return false
            }
        }
    }
}
