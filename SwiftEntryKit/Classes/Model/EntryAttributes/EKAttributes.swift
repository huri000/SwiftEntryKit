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

    private static var stretched: EKAttributes {
        var attributes = EKAttributes()
        attributes.shape = .stretched
        attributes.level = .aboveStatusBar
        attributes.rollOutAdditionalAnimation = nil
        return attributes
    }
    
    private static var floating: EKAttributes {
        var attributes = EKAttributes()
        attributes.shape = .floating(info: EKAttributes.Frame())
        attributes.level = .aboveStatusBar
        return attributes
    }
    
    public static var topFloating: EKAttributes {
        var attributes = floating
        attributes.location = .top
        return attributes
    }
    
    public static var bottomFloating: EKAttributes {
        var attributes = floating
        attributes.location = .bottom
        return attributes
    }
    
    public static var bottomStretched: EKAttributes {
        var attributes = stretched
        attributes.location = .bottom
        return attributes
    }
    
    public static var topStretched: EKAttributes {
        var attributes = stretched
        attributes.location = .top
        return attributes
    }
    
    // Gives default attributes - Can be changed
    public static var `default` = EKAttributes()
    
    // Counts the active entries. When 0 - no entry is currently / about to be presented.
    public internal(set) static var count: UInt = 0
    public static var isEmpty: Bool {
        return count == 0
    }
    
    // MARK: - Layout Presentation, Positioning and Animation
    
    // Describes the location of the context. Whether it comes from the top / bottom of the screen
    public var location = Location.top
    
    // Describes the share of the context
    public var shape = Shape.stretched
    
    // Signals the presentor to consider / ignore safe area. Can be used to present the message outside the safe area margins
    public var ignoreSafeArea = false
    
    // Describes the context background
    public var contentBackground = BackgroundStyle.visualEffect(style: .light)
    
    // Describes the backgruond outside the context
    public var background = BackgroundStyle.color(color: .clear)
    
    // Describe how long the context is visible before it is dismissed
    public var visibleDuration: TimeInterval = 4 // Use .infinity for infinate duration
    
    // Describes how the entry animates in and out
    public var entranceAnimation = Animation.fade
    public var exitAnimation = Animation.fade
    
    // Describes how the previous entry pops when a new entry is pushed
    public var rollOutAdditionalAnimation: Animation? = Animation(duration: 0.6, types: [.scale(scale: 0.8)])
    
    // Context presentation level
    public var level = WindowLevel.aboveStatusBar
    
    // TODO: Shadow
    public var shadow: Shadow!
    
    // MARK: - User Interaction
    
    // Describes what happens when the user interacts the background, passes touchss forward by default
    // Triggered when the user begin touch interaction with the bsckground
    public var backgroundInteraction = UserInteraction.disabled
    
    // Describes what happens when the user interacts the content, pismisses the content by default
    // Triggered when the user taps te entry
    public var contentInteraction = UserInteraction.dismiss
}

