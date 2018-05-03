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
        descriptionValue = "Describes the entry's maximum width limitation. It can stretch to the width of the screen, get screen edge less 40pts, or be 90% of the screen width"
        insertSegments(by: ["Stretch", "Min Edge", "90% Screen"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.positionConstraints.maxSize.width {
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
            attributesWrapper.attributes.positionConstraints.maxSize.width = .offset(value: 0)
        case 1:
            attributesWrapper.attributes.positionConstraints.maxSize.width = .constant(value: UIScreen.main.minEdge - 40)
        case 2:
            attributesWrapper.attributes.positionConstraints.maxSize.width = .ratio(value: 0.9)
        default:
            break
        }
    }
}
