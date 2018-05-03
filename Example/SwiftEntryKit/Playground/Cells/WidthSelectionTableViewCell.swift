//
//  WidthSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class WidthSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Width"
        descriptionValue = "Describes the entry's width inside the screen. It can be stretched to the margins, it can have an offset, can a constant or have a ratio to the screen"
        insertSegments(by: ["Stretch", "20pts Offset", "90% Screen"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.positionConstraints.size.width {
        case .offset(value: let value):
            if value == 0 {
                segmentedControl.selectedSegmentIndex = 0
            } else {
                segmentedControl.selectedSegmentIndex = 1
            }
        case .ratio(value: _):
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.positionConstraints.size.width = .offset(value: 0)
        case 1:
            attributesWrapper.attributes.positionConstraints.size.width = .offset(value: 20)
        case 2:
            attributesWrapper.attributes.positionConstraints.size.width = .ratio(value: 0.9)
        default:
            break
        }
    }
}
