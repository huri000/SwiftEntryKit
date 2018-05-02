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
        
        /** Describes safe area relation */
        public enum SafeArea {
            
            /** Entry overrides safe area */
            case overriden
            
            /** The entry shows outs. But can optionally be colored */
            case empty(fillSafeArea: Bool)
            
            public var isOverriden: Bool {
                switch self {
                case .overriden:
                    return true
                default:
                    return false
                }
            }
        }
        
        /** Describes the width constraint of the entry */
        public enum Edge {
            
            /** Ratio constraint to screen width */
            case ratio(value: CGFloat)
            
            /** Offset from each side of the screen */
            case offset(value: CGFloat)
            
            /** Constant width */
            case constant(value: CGFloat)
            
            /** Unspecified maximum width */
            case unspecified
        }
        
        /** The maximum width constraint of the entry */
        public var maximumWidth: Edge

        /** The width constraint of the entry */
        public var width: Edge
        
        /** The height constraint of the entry */
        public var height: Edge
        
        /** The vertical offset from the top or bottom anchor */
        public var verticalOffset: CGFloat
        
        /** Can be used to present content outside the safe area margins such as on the notch of the iPhone X or the status bar itself. */
        public var safeArea = SafeArea.empty(fillSafeArea: false)
        
        public var hasVerticalOffset: Bool {
            return verticalOffset > 0
        }
        
        /** Returns a full entry (Toast-Like) */
        public static var full: PositionConstraints {
            return PositionConstraints(verticalOffset: 0, width: .offset(value: 0))
        }
        
        /** Returns a floating entry (Float-Like) */
        public static var float: PositionConstraints {
            return PositionConstraints(verticalOffset: 10, width: .offset(value: 20))
        }
        
        public init(verticalOffset: CGFloat = 0, width: Edge = .offset(value: 0), height: Edge = .unspecified, maximumWidth: Edge = .unspecified) {
            self.verticalOffset = verticalOffset
            self.width = width
            self.height = height
            self.maximumWidth = maximumWidth
        }
    }
}
