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
    struct PositionConstraints {

        /** Describes safe area relation */
        public enum SafeArea {
            
            /** Entry overrides safe area */
            case overridden
            
            /** The entry shows outs. But can optionally be colored */
            case empty(fillSafeArea: Bool)
            
            public var isOverridden: Bool {
                switch self {
                case .overridden:
                    return true
                default:
                    return false
                }
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
            
            /** Edge totally filled */
            public static var fill: Edge {
                return .offset(value: 0)
            }
        }
        
        /** Describes the size of the entry */
        public struct Size {
            
            /** Describes a width constraint */
            public var width: Edge
            
            /** Describes a height constraint */
            public var height: Edge
            
            /** Initializer */
            public init(width: Edge, height: Edge) {
                self.width = width
                self.height = height
            }
            
            /** The content's size. Entry's content view must have tight constraints */
            public static var intrinsic: Size {
                return Size(width: .intrinsic, height: .intrinsic)
            }
            
            /** The content's size. Entry's content view must have tight constraints */
            public static var sizeToWidth: Size {
                return Size(width: .offset(value: 0), height: .intrinsic)
            }
            
            /** Screen size, without horizontal or vertical offset */
            public static var screen: Size {
                return Size(width: .fill, height: .fill)
            }
        }
        
        /** The relation to the keyboard's top and the screen's top while it is opened */
        public enum KeyboardRelation {
            
            /** Describes the offset when the keyboard is opened */
            public struct Offset {
                
                /** Describes top keyboard offset to the entry's bottom */
                public var bottom: CGFloat
                
                /** Describes top screen offset to the entry's top, useful to prevent the entry from exceeding the screen top bounds */
                public var screenEdgeResistance: CGFloat?
                
                public init(bottom: CGFloat = 0, screenEdgeResistance: CGFloat? = nil) {
                    self.bottom = bottom
                    self.screenEdgeResistance = screenEdgeResistance
                }
                
                /** None offset */
                public static var none: Offset {
                    return Offset()
                }
            }
            
            /** Bind the entry's bottom to the keyboard's top with an offset.
             Additionally, the top edge of the screen can have a resistance offset which the entry isn't able to cross.
             The resistance is mostly used when the device orientation changes and the entry's frame crosses the screen bounds.
             Current isn't supported with center entry position.*/
            case bind(offset: Offset)
            
            /** Entry is unbound to the keyboard. It's location doesn't change. */
            case unbind
            
            /** Returns true if the entry is bound to the keyboard */
            public var isBound: Bool {
                switch self {
                case .bind(offset: _):
                    return true
                case .unbind:
                    return false
                }
            }
        }
        
        /** Rotation related position constraints */
        public struct Rotation {
            
            /** Attributes of supported interface orientations */
            public enum SupportedInterfaceOrientation {
                
                /** Uses standard supported interface orientation (target specification in general settings) */
                case standard
                
                /** Supports all orinetations */
                case all
            }
            
            /** Autorotate the entry along with the device orientation */
            public var isEnabled = true
            
            /** The screen autorotates with accordance to this option */
            public var supportedInterfaceOrientations = SupportedInterfaceOrientation.standard
            
            public init() {}
        }
        
        /** The rotation attributes of the entry */
        public var rotation = Rotation()
        
        /** The entry can be bound to keyboard in case of appearance */
        public var keyboardRelation = KeyboardRelation.unbind
        
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
        
        /** Returns a floating entry (float-like) */
        public static var float: PositionConstraints {
            return PositionConstraints(verticalOffset: 10, size: .init(width: .offset(value: 20), height: .intrinsic))
        }
        
        /** A full width entry (toast-like) */
        public static var fullWidth: PositionConstraints {
            return PositionConstraints(verticalOffset: 0, size: .sizeToWidth)
        }
        
        /** A full screen entry - fills the entire screen, modal-like */
        public static var fullScreen: PositionConstraints {
            return PositionConstraints(verticalOffset: 0, size: .screen)
        }
        
        /** Initialize with default parameters */
        public init(verticalOffset: CGFloat = 0, size: Size = .sizeToWidth, maxSize: Size = .intrinsic) {
            self.verticalOffset = verticalOffset
            self.size = size
            self.maxSize = maxSize
        }
    }
}
