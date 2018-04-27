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
        
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .gradient(gradient: .init(colors: [.amber, .pinky], startPoint: .zero, endPoint: CGPoint(x: 1, y: 1)))
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 10, offset: .zero))
        var description = EntryAttributesDescription(with: attributes, title: "Preset I")
        floats.append(description)
        
        attributes = EKAttributes.bottomFloat
        attributes.entryBackground = .color(color: .redish)
        attributes.entryInteraction = .delayExit(by: 3)
        description = EntryAttributesDescription(with: attributes, title: "Preset II")
        floats.append(description)
        
        dataSource.append(("Floating Entries", floats))
    }
    
    private mutating func setupToastPresets() {
        
        var toasts: [EntryAttributesDescription] = []
        
        var attributes = EKAttributes.topToast
        var description = EntryAttributesDescription(with: attributes, title: "Preset I")
        toasts.append(description)

        attributes = .bottomToast
        description = EntryAttributesDescription(with: attributes, title: "Preset II")
        toasts.append(description)

        dataSource.append(("Toasts", toasts))
    }
    
    private mutating func setupNotePresets() {
        
        var notes: [EntryAttributesDescription] = []

        var attributes = EKAttributes.topToast
        attributes.windowLevel = .belowStatusBar
        attributes.entryBackground = .color(color: .satCyan)
        attributes.popBehavior = .animated(animation: .translation)
        var description = EntryAttributesDescription(with: attributes, title: "Standard Note")
        notes.append(description)

        attributes = EKAttributes.topToast
        attributes.windowLevel = .belowStatusBar
        attributes.entryInteraction = .absorbTouches
        attributes.displayDuration = .infinity
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .pinky)
        description = EntryAttributesDescription(with: attributes, title: "Processing Infinate Note")
        notes.append(description)

        attributes = EKAttributes.statusBar
        attributes.entryBackground = .color(color: .greenGrass)
        attributes.popBehavior = .animated(animation: .translation)
        description = EntryAttributesDescription(with: attributes, title: "Status Bar Cover Note")
        notes.append(description)
        
        dataSource.append(("Notes", notes))
    }
    
    private mutating func setupCustomPresets() {
        var customs: [EntryAttributesDescription] = []
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .dimmedBackground)
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .all(radius: 25)
        attributes.positionConstraints = EKAttributes.PositionConstraints(verticalOffset: 10, width: .offset(value: 20))
        var description = EntryAttributesDescription(with: attributes, title: "Custom Alert")
        customs.append(description)

        attributes = EKAttributes.bottomFloat
        attributes.displayDuration = 4
        attributes.screenBackground = .clear
        attributes.screenInteraction = .forward
        attributes.entryInteraction = .absorbTouches
        attributes.roundCorners = .none
        attributes.positionConstraints = EKAttributes.PositionConstraints(verticalOffset: 10, width: .offset(value: 20))
        description = EntryAttributesDescription(with: attributes, title: "View From Nib")
        customs.append(description)
        
        dataSource.append(("Complex Entries", customs))
    }
}
