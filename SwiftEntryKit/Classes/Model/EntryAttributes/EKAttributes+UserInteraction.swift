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
    public struct UserInteraction {
        
        public typealias Action = () -> ()
        
        public enum Default {
            case absorbTouches
            case delayExit(by: TimeInterval)
            case dismissEntry
            case forward // Pass the touch to the next responder
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
        
        public var defaultAction: Default
        public var customActions: [Action]
        
        public init(defaultAction: Default = .absorbTouches, customActions: [Action] = []) {
            self.defaultAction = defaultAction
            self.customActions = customActions
        }
        
        public static var dismiss: UserInteraction {
            return UserInteraction(defaultAction: .dismissEntry)
        }
        
        public static var forward: UserInteraction {
            return UserInteraction(defaultAction: .forward)
        }
        
        public static var absorbTouches: UserInteraction {
            return UserInteraction(defaultAction: .absorbTouches)
        }
        
        public static func delayExit(by delay: TimeInterval) -> UserInteraction {
            return UserInteraction(defaultAction: .delayExit(by: delay))
        }
    }
}
