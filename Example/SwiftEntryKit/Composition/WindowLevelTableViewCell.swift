//
//  WindowLevelTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class WindowLevelTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Window Level"
        descriptionValue = "The window level of the entry. Below or above the status bar"
        segmentedControl.insertSegment(withTitle: "BELOW", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "ABOVE", at: 1, animated: false)
    }
}
