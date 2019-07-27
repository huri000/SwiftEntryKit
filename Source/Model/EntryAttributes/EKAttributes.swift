//
//  EKAttributes.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public struct EKAttributes {
    
    // MARK: Identification
    
    /**
     A settable **optional** name that matches the entry-attributes.
     - Nameless entries cannot be inquired using *SwiftEntryKit.isCurrentlyDisplaying(entryNamed: _) -> Bool*
     */
    public var name: String?
    
    // MARK: Display Attributes
    
    /** Entry presentation window level */
    public var windowLevel = WindowLevel.statusBar
    
    /** The position of the entry inside the screen */
    public var position = Position.top

    /** The display manner of the entry. */
    public var precedence = Precedence.override(priority: .normal, dropEnqueuedEntries: false)
    
    /** Describes how long the entry is displayed before it is dismissed */
    public var displayDuration: DisplayDuration = 2 // Use .infinity for infinite duration
    
    /** The frame attributes of the entry */
    public var positionConstraints = PositionConstraints()
    
    // MARK: User Interaction Attributes
    
    /** Describes what happens when the user interacts the screen,
     forwards the touch to the application window by default */
    public var screenInteraction = UserInteraction.forward
    
    /** Describes what happens when the user interacts the entry,
     dismisses the content by default */
    public var entryInteraction = UserInteraction.dismiss

    /** Describes the scrolling behaviour of the entry.
     The entry can be swiped out and in with an ability to spring back with a jolt */
    public var scroll = Scroll.enabled(swipeable: true, pullbackAnimation: .jolt)
    
    /** Generate haptic feedback once the entry is displayed */
    public var hapticFeedbackType = NotificationHapticFeedback.none
    
    /** Describes the actions that take place when the entry appears or is being dismissed */
    public var lifecycleEvents = LifecycleEvents()
    
    // MARK: Theme & Style Attributes
    
    /** The display mode of the entry */
    public var displayMode = DisplayMode.inferred
    
    /** Describes the entry's background appearance while it shows */
    public var entryBackground = BackgroundStyle.clear
    
    /** Describes the background appearance while the entry shows */
    public var screenBackground = BackgroundStyle.clear
    
    /** The shadow around the entry */
    public var shadow = Shadow.none
    
    /** The corner attributes */
    public var roundCorners = RoundCorners.none
    
    /** The border around the entry */
    public var border = Border.none
    
    /** Preferred status bar style while the entry shows */
    public var statusBar = StatusBar.inferred
    
    // MARK: Animation Attributes
    
    /** Describes how the entry animates in */
    public var entranceAnimation = Animation.translation
    
    /** Describes how the entry animates out */
    public var exitAnimation = Animation.translation
    
    /** Describes the previous entry behaviour when a new entry with higher display-priority shows */
    public var popBehavior = PopBehavior.animated(animation: .translation)

    /** Init with default attributes */
    public init() {}
}
