//
//  EKAttributes+Frame.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    /** Describes the frame of the entry. It's limitations, width and offset from the anchor (top / bottom of the screen) */
    public struct PositionConstraints {
        
        /** Describes the width constraint of the entry */
        public enum Width {
            
            /** Ratio constraint to screen width */
            case ratio(value: CGFloat)
            
            /** Offset from each side of the screen */
            case offset(value: CGFloat)
        }
        
        /** The width constraint of the entry */
        public var width: Width
        
        /** The vertical offset from the top or bottom anchor */
        public var verticalOffset: CGFloat
        
        public var hasVerticalOffset: Bool {
            return verticalOffset > 0
        }
        
        public static var full: PositionConstraints {
            return PositionConstraints(verticalOffset: 0, width: .offset(value: 0))
        }
        
        public static var float: PositionConstraints {
            return PositionConstraints(verticalOffset: 10, width: .offset(value: 20))
        }
        
        public init(verticalOffset: CGFloat = 10, width: Width = .offset(value: 20)) {
            self.verticalOffset = verticalOffset
            self.width = width
        }
    }
}
