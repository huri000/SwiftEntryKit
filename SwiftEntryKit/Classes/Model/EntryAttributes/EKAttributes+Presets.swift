//
//  EKAttributes+Presets.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/23/18.
//

import Foundation

public extension EKAttributes {
    
    /** Default attributes - Can be mutated according to the hosting application theme */
    public static var `default` = EKAttributes()
    
    /** Toast preset - The frame fills margins and safe area is filled with background view */
    public static var toast: EKAttributes {
        var attributes = EKAttributes()
        attributes.frame = .full
        attributes.options.safeAreaBehavior = .empty(fillSafeArea: true)
        attributes.level = .aboveStatusBar
        attributes.options.exitBehavior = .animated(animation: nil)
        return attributes
    }
    
    /** Float preset - The frame margined and safe area is left cleared */
    public static var float: EKAttributes {
        var attributes = EKAttributes()
        attributes.frame = .float
        attributes.options.safeAreaBehavior = .empty(fillSafeArea: false)
        attributes.level = .aboveStatusBar
        return attributes
    }
    
    /** Preset for status bar entry - appears on top of the status bar */
    public static var statusBar: EKAttributes {
        var attributes = topToast
        attributes.contentInteraction = .absorbTouches
        attributes.options.safeAreaBehavior = .overriden
        return attributes
    }
    
    /** Preset for top float entry */
    public static var topFloat: EKAttributes {
        var attributes = float
        attributes.location = .top
        return attributes
    }
    
    /** Preset for bottom float entry */
    public static var bottomFloat: EKAttributes {
        var attributes = float
        attributes.location = .bottom
        return attributes
    }
    
    /** Preset for bottom toast entry */
    public static var bottomToast: EKAttributes {
        var attributes = toast
        attributes.location = .bottom
        return attributes
    }
    
    /** Preset for top toast entry */
    public static var topToast: EKAttributes {
        var attributes = toast
        attributes.location = .top
        return attributes
    }
}
