//
//  BorderSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/28/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class BorderSelectionTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Border"
        descriptionValue = "Add a border to the entry"
        insertSegments(by: ["Off", "On"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.border {
        case .none:
            segmentedControl.selectedSegmentIndex = 0
        case .value(color: _, width: _):
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.border = .none
        case 1:
            attributesWrapper.attributes.border = .value(color: UIColor.black, width: 0.5)
        default:
            break
        }
    }
}
