//
//  LocationSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class PositionSelectionTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Position"
        descriptionValue = "The position of the entry inside the screen"
        segmentedControl.insertSegment(withTitle: "TOP", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "BOTTOM", at: 1, animated: false)
    }
}
