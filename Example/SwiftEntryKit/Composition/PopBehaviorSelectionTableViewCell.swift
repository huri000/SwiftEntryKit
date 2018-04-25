//
//  ExitBehaviorSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

class PopBehaviorSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Entry Pop Behavior"
        descriptionValue = "Specifies how the entry pops out as the next entry is pushed in"
        segmentedControl.insertSegment(withTitle: "Overriden", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Animated", at: 1, animated: false)
    }
}
