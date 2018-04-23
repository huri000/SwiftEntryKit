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
    public struct Frame {
        
        /** Describes the width constraint of the entry */
        public enum WidthConstraint {
            
            /** Ratio constraint to screen width */
            case ratio(value: CGFloat)
            
            /** Offset from each side of the screen */
            case offset(value: CGFloat)
        }
        
        /** The width constraint of the entry */
        public var widthConstraint: WidthConstraint
        
        /** The vertical offset from the top or bottom anchor */
        public var verticalOffset: CGFloat
        
        /** Corner radio of the entry */
        public var cornerRadius: CGFloat
        
        var hasVerticalOffset: Bool {
            return verticalOffset > 0
        }
        
        public static var full: Frame {
            return Frame(verticalOffset: 0, widthConstraint: .offset(value: 0), cornerRadius: 0)
        }
        
        public static var float: Frame {
            return Frame(verticalOffset: 10, widthConstraint: .offset(value: 20), cornerRadius: 10)
        }
        
        public init(verticalOffset: CGFloat = 10, widthConstraint: WidthConstraint = .offset(value: 20), cornerRadius: CGFloat = 10) {
            self.verticalOffset = verticalOffset
            self.widthConstraint = widthConstraint
            self.cornerRadius = cornerRadius
        }
    }
}
