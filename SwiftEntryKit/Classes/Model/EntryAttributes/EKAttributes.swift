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
    
    /** The location of the entry inside the screen */
    public var location = Location.top
    
    /** The frame attributes of the entry */
    public var frame = Frame()
    
    /** Describes the entry's background appearance while it shows */
    public var contentBackground = BackgroundStyle.visualEffect(style: .light)
    
    /** Describes the background appearance while the entry shows */
    public var background = BackgroundStyle.color(color: .clear)
    
    /** Describes how long the entry is visible before it is dismissed */
    public var visibleDuration: TimeInterval = 4 // Use .infinity for infinate duration
    
    // Describes how the entry animates in and out
    public var entranceAnimation = Animation.fade
    public var exitAnimation = Animation.fade
    
    /** Entry presentation level */
    public var level = WindowLevel.aboveStatusBar
    
    // TODO: Add Shadow
    public var shadow: Shadow!
    
    // TODO: Add corners
    public var corners: Corners!
    
    // MARK: - User Interaction
    
    // Describes what happens when the user interacts the background, passes touchss forward by default
    // Triggered when the user begin touch interaction with the bsckground
    public var backgroundInteraction = UserInteraction.disabled
    
    // Describes what happens when the user interacts the content, dismisses the content by default
    // Triggered when the user taps te entry
    public var contentInteraction = UserInteraction.dismiss

    // MARK: Additional Options
    
    /** Additional options that could be applied to an *EKAttributes* instance */
    public var options = Options()
}
