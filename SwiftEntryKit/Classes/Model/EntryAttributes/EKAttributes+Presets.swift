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
        attributes.positionConstraints = .full
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.windowLevel = .aboveStatusBar
        attributes.options.scroll = .edgeCrossingDisabled
        attributes.popBehavior = .animated(animation: .translation)
        return attributes
    }
    
    /** Float preset - The frame margined and safe area is left cleared */
    public static var float: EKAttributes {
        var attributes = EKAttributes()
        attributes.positionConstraints = .float
        attributes.roundCorners = .all(radius: 10)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.windowLevel = .aboveStatusBar
        return attributes
    }
    
    /** Preset for top float entry */
    public static var topFloat: EKAttributes {
        var attributes = float
        attributes.position = .top
        return attributes
    }
    
    /** Preset for bottom float entry */
    public static var bottomFloat: EKAttributes {
        var attributes = float
        attributes.position = .bottom
        return attributes
    }
    
    /** Preset for bottom toast entry */
    public static var bottomToast: EKAttributes {
        var attributes = toast
        attributes.position = .bottom
        return attributes
    }
    
    /** Preset for top toast entry */
    public static var topToast: EKAttributes {
        var attributes = toast
        attributes.position = .top
        return attributes
    }
    
    /** Preset for top note entry */
    public static var topNote: EKAttributes {
        var attributes = topToast
        attributes.options.scroll = .disabled
        attributes.windowLevel = .belowStatusBar
        attributes.entryInteraction = .absorbTouches
        return attributes
    }
    
    /** Preset for status bar entry - appears on top of the status bar */
    public static var statusBar: EKAttributes {
        var attributes = topToast
        attributes.windowLevel = .aboveStatusBar
        attributes.entryInteraction = .absorbTouches
        attributes.positionConstraints.safeArea = .overriden
        return attributes
    }
}
