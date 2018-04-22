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
    
    /** Default attributes - Can be mutated according to the hosting application theme */
    public static var `default` = EKAttributes()
    
    // MARK: - Layout Presentation, Positioning and Animation
    
    /** The location of the entry at the sceeen */
    public var location = Location.top
    
    /** The shape of the entry */
    public var shape = Shape.stretched
    
    /** Describes the entry's background appearance while it shows */
    public var contentBackground = BackgroundStyle.visualEffect(style: .light)
    
    /** Describes the background appearance while the entry shows */
    public var background = BackgroundStyle.color(color: .clear)
    
    /** Describes how long the entry is visible before it is dismissed */
    public var visibleDuration: TimeInterval = 4 // Use .infinity for infinate duration
    
    // Describes how the entry animates in and out
    public var entranceAnimation = Animation.fade
    public var exitAnimation = Animation.fade
    
    /** Describes how the previous entry pops when a new entry is pushed

     - note: This animation is applied additionally to *exitAnimation* which is the default
     */
    public var rollOutAdditionalAnimation: Animation? = Animation(duration: 0.6, types: [.scale])
    
    /** Entry presentation level */
    public var level = WindowLevel.aboveStatusBar
    
    // TODO: Add Shadow
    public var shadow: Shadow!
    
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
