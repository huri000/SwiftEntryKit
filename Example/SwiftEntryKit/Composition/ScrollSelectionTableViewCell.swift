//
//  ScrollSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ScrollSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Scroll Behavior"
        descriptionValue = "Describes whether the entry is vertically scrollable"
        segmentedControl.insertSegment(withTitle: "Disabled", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Loose", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "One Side", at: 2, animated: false)
    }
}
