//
//  EKAttributes+UserInteraction.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

public extension EKAttributes {
    
    /** Describes the user interaction events that are triggered as the user taps the entry / screen */
    struct UserInteraction {
        
        /** Code that is executed when the user taps the entry / screen */
        public typealias Action = () -> ()
        
        /** The default event that happens as the user interacts */
        public enum Default {
            
            /** Absorbs touches. The entry / screen does nothing (Swallows the touch) */
            case absorbTouches
            
            /** Touches delay the exit of the entry */
            case delayExit(by: TimeInterval)
            
            /** Taps dismiss the entry immediately */
            case dismissEntry
            
            /** Touches are forwarded to the lower window (In most cases it would be the application main window that will handle it */
            case forward
        }
        
        var isResponsive: Bool {
            switch defaultAction {
            case .forward:
                return false
            default:
                return true
            }
        }
        
        var isDelayExit: Bool {
            switch defaultAction {
            case .delayExit:
                return true
            default:
                return false
            }
        }
        
        /** A default action that is executed when the entry or the screen are interacted by the user */
        public var defaultAction: Default
        
        /** Additional actions that can be customized by the user */
        public var customTapActions: [Action]
        
        public init(defaultAction: Default = .absorbTouches, customTapActions: [Action] = []) {
            self.defaultAction = defaultAction
            self.customTapActions = customTapActions
        }
        
        /** Dismiss action */
        public static var dismiss: UserInteraction {
            return UserInteraction(defaultAction: .dismissEntry)
        }
        
        /** Forward action */
        public static var forward: UserInteraction {
            return UserInteraction(defaultAction: .forward)
        }
        
        /** Absorb touches action */
        public static var absorbTouches: UserInteraction {
            return UserInteraction(defaultAction: .absorbTouches)
        }
        
        /** Delay exit action */
        public static func delayExit(by delay: TimeInterval) -> UserInteraction {
            return UserInteraction(defaultAction: .delayExit(by: delay))
        }
    }
}
