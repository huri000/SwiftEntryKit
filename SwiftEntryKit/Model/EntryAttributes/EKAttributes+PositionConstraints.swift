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
        
        /** Describes the size of the entry */
        public struct Size {
            
            /** Describes a width constraint */
            public var width: Edge
            
            /** Describes a height constraint */
            public var height: Edge
            
            public init(width: Edge, height: Edge) {
                self.width = width
                self.height = height
            }
            
            public static var intrinsic: Size {
                return Size(width: .intrinsic, height: .intrinsic)
            }
            
            public static var sizeToWidth: Size {
                return Size(width: .offset(value: 0), height: .intrinsic)
            }
        }
        
        /** Describes an edge constraint of the entry */
        public enum Edge {
            
            /** Ratio constraint to screen edge */
            case ratio(value: CGFloat)
            
            /** Offset from each edge of the screen */
            case offset(value: CGFloat)
            
            /** Constant edge length */
            case constant(value: CGFloat)
            
            /** Unspecified edge length */
            case intrinsic
        }
        
        /** The size of the entry */
        public var size: Size
        
        /** The maximum size of the entry */
        public var maxSize: Size
        
        /** The vertical offset from the top or bottom anchor */
        public var verticalOffset: CGFloat
        
        /** Can be used to display the content outside the safe area margins such as on the notch of the iPhone X or the status bar itself. */
        public var safeArea = SafeArea.empty(fillSafeArea: false)
        
        public var hasVerticalOffset: Bool {
            return verticalOffset > 0
        }
        
        /** Returns a full entry (Toast-Like) */
        public static var full: PositionConstraints {
            return PositionConstraints(verticalOffset: 0, size: .sizeToWidth)
        }
        
        /** Returns a floating entry (Float-Like) */
        public static var float: PositionConstraints {
            return PositionConstraints(verticalOffset: 10, size: .init(width: .offset(value: 20), height: .intrinsic))
        }
        
        public init(verticalOffset: CGFloat = 0, size: Size = .sizeToWidth, maxSize: Size = .intrinsic) {
            self.verticalOffset = verticalOffset
            self.size = size
            self.maxSize = .intrinsic
        }
    }
}
