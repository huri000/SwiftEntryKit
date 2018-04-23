//
//  VisibleDurationTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class DisplayDurationTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Display Duration"
        descriptionValue = "How long the entry is displayed"
        segmentedControl.insertSegment(withTitle: "2 Seconds", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "4 Seconds", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Infinate", at: 2, animated: false)
    }
}
