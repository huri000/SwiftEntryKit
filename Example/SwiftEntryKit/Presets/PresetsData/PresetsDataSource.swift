//
//  PresetsDataSource.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/27/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation
import SwiftEntryKit

struct PresetsDataSource {
    
    // Cluster of presets, aggregated under name
    typealias Cluster = (title: String, data: [PresetDescription])
    
    private enum ThumbDesc: String {
        case bottomToast = "ic_bottom_toast"
        case bottomFloat = "ic_bottom_float"
        case topToast = "ic_top_toast"
        case topFloat = "ic_top_float"
        case bottomPopup = "ic_bottom_popup"
    }
    
    private(set) var dataSource: [Cluster] = []
    
    private(set) subscript(section: Int) -> Cluster {
        get {
            return dataSource[section]
        }
        set {
            return dataSource[section] = newValue
        }
    }
    
    private(set) subscript(section: Int, index: Int) -> PresetDescription {
        get {
            return dataSource[section].data[index]
        }
        set {
            return dataSource[section].data[index] = newValue
        }
    }
    
    // Cumputed for the sake of reusability
    var bottomAlertAttributes: EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.entryBackground = .color(color: .white)
        attributes.screenBackground = .color(color: .dimmedLightBackground)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 25)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)),
                                             scale: .init(from: 1.05, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBarStyle = .default
        return attributes
    }
    
    // MARK: Setup
    init() {
        setupToastPresets()
        setupNotePresets()
        setupFloatPresets()
        setupCustomPresets()
    }
    
    private mutating func setupToastPresets() {
        
        var toasts: [PresetDescription] = []
        var attributes: EKAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = .topToast
        attributes.entryBackground = .color(color: EKColor.LightBlue.a700)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.3), scale: .init(from: 1.07, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(translate: .init(duration: 0.3))
        attributes.scroll = .edgeCrossingDisabled(swipeable: false)
        descriptionString = "The entry fades in and exits with transition upwards. Not swipeable"
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Top I", description: descriptionString, thumb: descriptionThumb)
        toasts.append(description)

        // Preset II
        attributes = .topToast
        attributes.entryBackground = .color(color: .darkChatMessage)
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.displayDuration = 4
        attributes.shadow = .active(with: .init(color: .darkChatMessage, opacity: 0.5, radius: 10, offset: .zero))
        descriptionString = "The entry has a dark background with a chat message style. Displayed for \(attributes.displayDuration)s. Once a new entry shows, it's overridden promptly"
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Top II", description: descriptionString, thumb: descriptionThumb)
        toasts.append(description)
        
        // Preset III
        attributes = .bottomToast
        attributes.entryBackground = .visualEffect(style: .light)
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.statusBarStyle = .default
        descriptionString = "The entry has an light blurred background"
        descriptionThumb = ThumbDesc.bottomToast.rawValue
        description = .init(with: attributes, title: "Bottom", description: descriptionString, thumb: descriptionThumb)
        toasts.append(description)
        
        dataSource.append(("Toasts", toasts))
    }
    
    private mutating func setupNotePresets() {
        
        var notes: [PresetDescription] = []
        var attributes: EKAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = .topNote
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .satCyan)
        attributes.statusBarStyle = .lightContent
        descriptionString = "The entry absorbs (ignores) touches and the status bar becomes light."
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Top Standard Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)

        // Preset II
        attributes = .topNote
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .pinky)
        attributes.statusBarStyle = .lightContent
        descriptionString = "Appears for an infinate duration"
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Top Processing Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)

        // Preset III
        attributes = .statusBar
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .greenGrass)
        descriptionString = "Overrides the status bar"
        descriptionThumb = ThumbDesc.topToast.rawValue
        description = .init(with: attributes, title: "Status Bar Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)
        
        // Preset IV
        attributes = .bottomNote
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6, offset: .zero))
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor.Purple.a300, EKColor.Purple.a400, EKColor.Purple.a700], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.statusBarStyle = .default
        descriptionString = "Presented at the bottom / Above the notch, with a mild gradient and shadow"
        descriptionThumb = ThumbDesc.bottomToast.rawValue
        description = .init(with: attributes, title: "Bottom Standard Note", description: descriptionString, thumb: descriptionThumb)
        notes.append(description)
        
        dataSource.append(("Notes", notes))
    }
    
    private mutating func setupFloatPresets() {
        
        var floats: [PresetDescription] = []
        var description: PresetDescription
        var attributes: EKAttributes
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = .topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [.amber, .pinky], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3), scale: .init(from: 1, to: 0.7, duration: 0.7)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBarStyle = .default
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .easeOut)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Has a gradient content background and a drop shadow. It's max width is the screen minimal edge. Can be swiped out but doesn't spring with damp"
        descriptionThumb = ThumbDesc.topFloat.rawValue
        description = .init(with: attributes, title: "Top", description: descriptionString, thumb: descriptionThumb)
        floats.append(description)
        
        // Preset II
        attributes = .bottomFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor.BlueGradient.dark, EKColor.BlueGradient.light], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.entryInteraction = .delayExit(by: 3)
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.statusBarStyle = .default
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Has a colored content background. Touches delay the exit by 3 seconds"
        descriptionThumb = ThumbDesc.bottomFloat.rawValue
        description = .init(with: attributes, title: "Bottom", description: descriptionString, thumb: descriptionThumb)
        floats.append(description)
        
        dataSource.append(("Floats", floats))
    }
    
    private mutating func setupCustomPresets() {
        
        var customs: [PresetDescription] = []
        var attributes: EKAttributes
        var description: PresetDescription
        var descriptionString: String
        var descriptionThumb: String

        // Preset I
        attributes = bottomAlertAttributes
        descriptionString = "Customized pop up with round corners. It has a button that receives an action. The background gets dimmed and any touch on it dismisses the entry"
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Pop Up I", description: descriptionString, thumb: descriptionThumb)
        customs.append(description)
        
        // Preset II
        attributes = EKAttributes.centerFloat
        attributes.displayDuration = .infinity
        attributes.entryBackground = .gradient(gradient: .init(colors: [UIColor(rgb: 0xfffbd5), UIColor(rgb: 0xb20a2c)], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.screenBackground = .color(color: .dimmedDarkBackground)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 8, offset: .zero))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.roundCorners = .all(radius: 8)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)),
                                             scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.exitAnimation = .init(translate: .init(duration: 0.2))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.2)))
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        attributes.statusBarStyle = .default
        descriptionString = "Customized pop up with round corners. It has a button that receives an action. The background gets dimmed and any touch on it dismisses the entry"
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Pop Up II", description: descriptionString, thumb: descriptionThumb)
        customs.append(description)
        
        
        // Preset III
        attributes = bottomAlertAttributes
        attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.5, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor.LightPink.first, EKColor.LightPink.last], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.positionConstraints = .full
        attributes.positionConstraints.safeArea = .empty(fillSafeArea: true)
        attributes.roundCorners = .top(radius: 20)
        descriptionString = "Customized pop up with top round corners. Strectched to the width of the screen. It has a button that receives an action."
        descriptionThumb = ThumbDesc.bottomPopup.rawValue
        description = .init(with: attributes, title: "Pop Up III", description: descriptionString, thumb: descriptionThumb)
        customs.append(description)
        
        // Preset IV
        attributes = .bottomFloat
        attributes.displayDuration = 3
        attributes.screenBackground = .clear
        attributes.entryBackground = .clear
        attributes.screenInteraction = .forward
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .all(radius: 5)
        
        attributes.entranceAnimation = .init(translate: .init(duration: 0.5, spring: .init(damping: 0.9, initialVelocity: 0)),
                                             scale: .init(from: 0.8, to: 1, duration: 0.5, spring: .init(damping: 0.8, initialVelocity: 0)),
                                             fade: .init(from: 0.7, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(translate: .init(duration: 0.5),
                                         scale: .init(from: 1, to: 0.8, duration: 0.5),
                                         fade: .init(from: 1, to: 0, duration: 0.5))
        attributes.popBehavior = .animated(animation: .init(translate: .init(duration: 0.3),
                                                            scale: .init(from: 1, to: 0.8, duration: 0.3)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6, offset: .zero))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.size = .init(width: .offset(value: 20), height: .intrinsic)
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        
        attributes.statusBarStyle = .default
        descriptionString = "Customized view that is initialized by a nib file, it is additionally added various attributes such as round corners and a mild shadow"
        descriptionThumb = ThumbDesc.bottomFloat.rawValue
        description = .init(with: attributes, title: "View From Nib", description: descriptionString, thumb: descriptionThumb)
        customs.append(description)
        
        // Preset V
        attributes = .topFloat
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        attributes.screenBackground = .color(color: .dimmedLightBackground)
        attributes.entryBackground = .color(color: .white)
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 1, initialVelocity: 0)), scale: .init(from: 0.6, to: 1, duration: 0.7), fade: .init(from: 0.8, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(scale: .init(from: 1, to: 0.7, duration: 0.3), fade: .init(from: 1, to: 0, duration: 0.3))            
        attributes.displayDuration = .infinity
        attributes.border = .value(color: .black, width: 0.5)
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 5, offset: .zero))
        attributes.statusBarStyle = .default
        attributes.positionConstraints.maxSize = .init(width: .constant(value: UIScreen.main.minEdge), height: .intrinsic)
        descriptionString = "Customized view with internal animation. It has a drop shadow, round corners and a mild border"
        descriptionThumb = ThumbDesc.topFloat.rawValue
        description = .init(with: attributes, title: "Custom View", description: descriptionString, thumb: descriptionThumb)
        customs.append(description)

        dataSource.append(("Complex Entries", customs))
    }
}
