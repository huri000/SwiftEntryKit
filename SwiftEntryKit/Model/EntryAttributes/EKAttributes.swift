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
    
    /** Init with default attributes */
    public init() {}
        
    /** Entry presentation window level */
    public var windowLevel = WindowLevel.aboveStatusBar
    
    /** The position of the entry inside the screen */
    public var position = Position.top

    /** The display priority of the entry */
    public var displayPriority = DisplayPriority.normal
    
    /** Describes how long the entry is displayed before it is dismissed */
    public var displayDuration: TimeInterval = 2 // Use .infinity for infinate duration
    
    /** The frame attributes of the entry */
    public var positionConstraints = PositionConstraints()
    
    /** Describes the entry's background appearance while it shows */
    public var entryBackground = BackgroundStyle.clear
    
    /** Describes the background appearance while the entry shows */
    public var screenBackground = BackgroundStyle.clear
    
    /** Describes what happens when the user interacts the screen,
     forwards the touch to the application window by default */
    public var screenInteraction = UserInteraction.forward
    
    /** Describes what happens when the user interacts the entry, dismisses the content by default */
    public var entryInteraction = UserInteraction.dismiss

    /** The shadow attributes */
    public var shadow = Shadow.none
    
    /** The corner attributes */
    public var roundCorners = RoundCorners.none
    
    /** The border attributes around the entry */
    public var border = Border.none
    
    /** Describes how the entry animates in */
    public var entranceAnimation = Animation.translation
    
    /** Describes how the entry animates out */
    public var exitAnimation = Animation.translation
    
    /** Describes the previous entry behaviour when the current entry shows */
    public var popBehavior = PopBehavior.animated(animation: .translation)
    
    /** Describes the scrolling behaviour of the entry - The entry can be swiped out and in with an ability to spring back like a rubber band */
    public var scroll = Scroll.enabled(swipeable: true, pullbackAnimation: .jolt)
    
    /** Preferred status bar style while the entry shows */
    public var statusBarStyle: UIStatusBarStyle!
    
    /** Generate haptic feedback once the entry is displayed */
    public var hapticFeedbackType = NotificationHapticFeedback.none
}
