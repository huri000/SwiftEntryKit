//
//  NotificationFeedbackSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class HapticFeedbackSelectionTableViewCell: SelectionTableViewCell {
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Notification Haptic Feedback"
        descriptionValue = "Generate a haptic feedback once the entry shows"
        insertSegments(by: ["Off", "On"])
        selectSegment()
    }
    
    private func selectSegment() {
        if !attributesWrapper.attributes.options.useHapticFeedback {
            segmentedControl.selectedSegmentIndex = 0
        } else {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.options.useHapticFeedback = false
        case 1:
            attributesWrapper.attributes.options.useHapticFeedback = true
        default:
            break
        }
    }
}
