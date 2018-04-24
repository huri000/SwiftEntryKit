//
//  EKAttributes+Shadow.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public extension EKAttributes {
    
    /** Shadow attributes */
    public struct Shadow {
        public var radius: CGFloat
        public var opacity: CGFloat
        public var color: UIColor
        public var offset: CGPoint
        
        public init(color: UIColor = .black, opacity: CGFloat, radius: CGFloat, offset: CGPoint) {
            self.color = color
            self.radius = radius
            self.offset = offset
            self.opacity = opacity
        }
    }
    
    /** Corner radius of the entry */
    public enum RoundCorners {
        case none
        case all(radius: CGFloat)
        case top(radius: CGFloat)
        case bottom(radius: CGFloat)
        
        public var hasRoundCorners: Bool {
            switch self {
            case .none:
                return false
            default:
                return true
            }
        }
        
        public var cornerValues: (value: UIRectCorner, radius: CGFloat) {
            switch self {
            case .all(radius: let radius):
                return (value: .allCorners, radius: radius)
            case .top(radius: let radius):
                return (value: .top, radius: radius)
            case .bottom(radius: let radius):
                return (value: .bottom, radius: radius)
            case .none:
                return (value: [], radius: 0)
            }
        }
    }
}


