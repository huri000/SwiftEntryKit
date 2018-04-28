//
//  MaxWidthSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/26/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class MaxWidthSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Max Width"
        descriptionValue = "Describes the entry's maximum width limitation"
        insertSegments(by: ["Stretch", "310pts", "90% Screen"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.positionConstraints.maximumWidth {
        case .offset(value: _):
            segmentedControl.selectedSegmentIndex = 0
        case .constant(value: _):
            segmentedControl.selectedSegmentIndex = 1
        case .ratio(value: 0.9):
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.positionConstraints.maximumWidth = .offset(value: 0)
        case 1:
            attributesWrapper.attributes.positionConstraints.maximumWidth = .constant(value: 310)
        case 2:
            attributesWrapper.attributes.positionConstraints.maximumWidth = .ratio(value: 0.9)
        default:
            break
        }
    }
}
