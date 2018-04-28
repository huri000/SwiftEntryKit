//
//  UserInteractionSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

class UserInteractionSelectionTableViewCell: SelectionTableViewCell {
        
    var focus: Focus = .entry
    
    private var interactionAction: EKAttributes.UserInteraction.Default {
        get {
            switch focus {
            case .entry:
                return attributesWrapper.attributes.entryInteraction.defaultAction
            case .screen:
                return attributesWrapper.attributes.screenInteraction.defaultAction
            }
        }
        set {
            switch focus {
            case .entry:
                attributesWrapper.attributes.entryInteraction.defaultAction = newValue
            case .screen:
                attributesWrapper.attributes.screenInteraction.defaultAction = newValue
            }
        }
    }
    
    func configure(attributesWrapper: EntryAttributeWrapper, focus: Focus) {
        self.focus = focus
        configure(attributesWrapper: attributesWrapper)
    }
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "\(focus.rawValue.capitalized) User Interaction"
        descriptionValue = "Describes what happens when the user taps the \(focus.rawValue). The touch can be absorbed, delay the exit, be forwarded to the window below, or dismiss the entry."
        
        insertSegments(by: ["Absorb", "Delay", "Forward", "Dismiss"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch interactionAction {
        case .absorbTouches:
            segmentedControl.selectedSegmentIndex = 0
        case .delayExit(by: _):
            segmentedControl.selectedSegmentIndex = 1
        case .forward:
            segmentedControl.selectedSegmentIndex = 2
        case .dismissEntry:
            segmentedControl.selectedSegmentIndex = 3
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            interactionAction = .absorbTouches
        case 1:
            interactionAction = .delayExit(by: 4)
        case 2:
            interactionAction = .forward
        case 3:
            interactionAction = .dismissEntry
        default:
            break
        }
    }
}
