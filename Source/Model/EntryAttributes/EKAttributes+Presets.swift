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
        attributes.positionConstraints = .fullWidth
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.windowLevel = .statusBar
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.popBehavior = .animated(animation: .translation)
        return attributes
    }
    
    /** Float preset - The frame is margined and the safe area is left cleared */
    public static var float: EKAttributes {
        var attributes = EKAttributes()
        attributes.positionConstraints = .float
        attributes.roundCorners = .all(radius: 10)
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: false)
        attributes.windowLevel = .statusBar
        return attributes
    }
    
    /** Preset for top float entry */
    public static var topFloat: EKAttributes {
        var attributes = float
        attributes.position = .top
        return attributes
    }
    
    /** Preset for a bottom float entry */
    public static var bottomFloat: EKAttributes {
        var attributes = float
        attributes.position = .bottom
        return attributes
    }
    
    /** Preset for a center float entry */
    public static var centerFloat: EKAttributes {
        var attributes = float
        attributes.position = .center
        return attributes
    }
    
    /** Preset for a bottom toast entry */
    public static var bottomToast: EKAttributes {
        var attributes = toast
        attributes.position = .bottom
        return attributes
    }
    
    /** Preset for a top toast entry */
    public static var topToast: EKAttributes {
        var attributes = toast
        attributes.position = .top
        return attributes
    }
    
    /** Preset for a top note entry */
    public static var topNote: EKAttributes {
        var attributes = topToast
        attributes.scroll = .disabled
        attributes.windowLevel = .normal
        attributes.entryInteraction = .absorbTouches
        return attributes
    }
    
    /** Preset for a bottom note entry */
    public static var bottomNote: EKAttributes {
        var attributes = bottomToast
        attributes.scroll = .disabled
        attributes.windowLevel = .normal
        attributes.entryInteraction = .absorbTouches
        return attributes
    }
    
    /** Preset for a status bar entry - appears on top of the status bar */
    public static var statusBar: EKAttributes {
        var attributes = topToast
        attributes.windowLevel = .statusBar
        attributes.entryInteraction = .absorbTouches
        attributes.positionConstraints.safeArea = .overridden
        return attributes
    }
}
