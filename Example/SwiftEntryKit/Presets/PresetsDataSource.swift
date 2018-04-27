//
//  PresetsDataSource.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import SwiftEntryKit

struct PresetsDataSource {
    
    typealias Cluster = (title: String, data: [EntryAttributesDescription])
    
    var dataSource: [Cluster] = []
    
    private(set) subscript(section: Int) -> Cluster {
        get {
            return dataSource[section]
        }
        set {
            return dataSource[section] = newValue
        }
    }
    
    private(set) subscript(section: Int, index: Int) -> EntryAttributesDescription {
        get {
            return dataSource[section].data[index]
        }
        set {
            return dataSource[section].data[index] = newValue
        }
    }
    
    init() {
        setupToastPresets()
        setupNotePresets()
        setupFloatPresets()
        setupCustomPresets()
    }

    private mutating func setupFloatPresets() {
        
        var floats: [EntryAttributesDescription] = []
        var description: EntryAttributesDescription
        var attributes: EKAttributes
        var descriptionString: String
        
        // Preset I
        attributes = .topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [.amber, .pinky], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        attributes.statusBarStyle = .default
        descriptionString = "Has a gradient content background and a drop shadow"
        description = .init(with: attributes, title: "Top", description: descriptionString)
        floats.append(description)
        
        // Preset II
        attributes = .bottomFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor.BlueGradient.dark, EKColor.BlueGradient.light], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.entryInteraction = .delayExit(by: 3)
        attributes.statusBarStyle = .default
        descriptionString = "Has a colored content background. Touches delay the exit by 3 seconds"
        description = .init(with: attributes, title: "Bottom", description: descriptionString)
        floats.append(description)
        
        dataSource.append(("Floats", floats))
    }
    
    private mutating func setupToastPresets() {
        
        var toasts: [EntryAttributesDescription] = []
        var attributes: EKAttributes
        var description: EntryAttributesDescription
        var descriptionString: String
        
        // Preset I
        attributes = .topToast
        attributes.entryBackground = .color(color: EKColor.LightBlue.a700)
        attributes.entranceAnimation = .init(duration: 0.5, types: [.fade(from: 0, to: 1)])
        attributes.exitAnimation = .translation
        descriptionString = "The entry fades in and exits with transition upwards"
        description = EntryAttributesDescription(with: attributes, title: "Top I", description: descriptionString)
        toasts.append(description)

        // Preset II
        attributes = .topToast
        attributes.entryBackground = .color(color: .darkChatMessage)
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation
        attributes.displayDuration = 4
        attributes.shadow = .active(with: .init(color: .darkChatMessage, opacity: 0.5, radius: 10, offset: .zero))
        attributes.popBehavior = .overriden
        descriptionString = "The entry has a dark background with a chat message style. Displayed for \(attributes.displayDuration)s. Once a new entry shows, it's overridden promptly"
        description = EntryAttributesDescription(with: attributes, title: "Top II", description: descriptionString)
        toasts.append(description)
        
        // Preset III
        attributes = .bottomToast
        attributes.entryBackground = .visualEffect(style: .light)
        attributes.statusBarStyle = .default
        descriptionString = "The entry has an light blurred background"
        description = EntryAttributesDescription(with: attributes, title: "Bottom", description: descriptionString)
        toasts.append(description)
        
        dataSource.append(("Toasts", toasts))
    }
    
    private mutating func setupNotePresets() {
        
        var notes: [EntryAttributesDescription] = []
        var attributes: EKAttributes
        var description: EntryAttributesDescription
        var descriptionString: String
        
        // Preset I
        attributes = .topNote
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .satCyan)
        attributes.statusBarStyle = .lightContent
        descriptionString = "The entry absorbs (ignores) touches and the status bar becomes light."
        description = .init(with: attributes, title: "Top Standard Note", description: descriptionString)
        notes.append(description)

        // Preset II
        attributes = .topNote
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .pinky)
        attributes.statusBarStyle = .lightContent
        descriptionString = "Appears for an infinate duration"
        description = .init(with: attributes, title: "Top Processing Note", description: descriptionString)
        notes.append(description)

        // Preset III
        attributes = .statusBar
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .greenGrass)
        descriptionString = "Overrides the status bar"
        description = .init(with: attributes, title: "Status Bar Note", description: descriptionString)
        notes.append(description)
        
        // Preset IV
        attributes = .bottomNote
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6, offset: .zero))
        attributes.entryBackground = .gradient(gradient: .init(colors: [EKColor.Purple.a300, EKColor.Purple.a400, EKColor.Purple.a700], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        descriptionString = "Presented at the bottom / Above the notch, with a mild gradient and shadow"
        description = .init(with: attributes, title: "Bottom Standard Note", description: descriptionString)
        notes.append(description)
        
        dataSource.append(("Notes", notes))
    }
    
    private mutating func setupCustomPresets() {
        
        var customs: [EntryAttributesDescription] = []
        var attributes: EKAttributes
        var description: EntryAttributesDescription
        var descriptionString: String
        
        // Preset I
        attributes = .bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .dimmedBackground)
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .all(radius: 25)
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.width = .offset(value: 20)
        
        descriptionString = "Customized alert view with round corners. It has a button that receives an action. The background gets dimmed and any touch on it dismisses the entry"
        description = .init(with: attributes, title: "Custom Alert", description: descriptionString)
        customs.append(description)

        // Preset II
        attributes = .bottomFloat
        attributes.displayDuration = 4
        attributes.screenBackground = .clear
        attributes.entryBackground = .clear
        attributes.screenInteraction = .forward
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .all(radius: 5)
        attributes.entranceAnimation = .init(duration: 0.2, types: [.translate, .scale(from: 0.8, to: 1)])
        attributes.exitAnimation = .init(duration: 0.5, types: [.fade(from: 1, to: 0), .scale(from: 1, to: 0.8)])
        attributes.popBehavior = .animated(animation: .init(duration: 0.3, types: [.translate, .scale(from: 1, to: 0.8)]))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 6, offset: .zero))
        attributes.positionConstraints.verticalOffset = 10
        attributes.positionConstraints.width = .offset(value: 20)
        descriptionString = "Customized view that is initialized by a nib file, it is additionally added various attributes such as round corners and a mild shadow"
        description = .init(with: attributes, title: "View From Nib", description: descriptionString)
        customs.append(description)
        
        dataSource.append(("Complex Entries", customs))
    }
}
