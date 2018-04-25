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
        descriptionValue = "Generate notification haptic feedback as the entry shows"
        segmentedControl.insertSegment(withTitle: "Off", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "On", at: 1, animated: false)
    }
}
