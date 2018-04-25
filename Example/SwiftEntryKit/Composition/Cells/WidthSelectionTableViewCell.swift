//
//  WidthSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class WidthSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Entry Width Constraint"
        descriptionValue = "Describes the entry width constraint"
        insertSegments(by: ["Offset", "Ratio", "Constant"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.positionConstraints.width {
        case .offset(value: _):
            segmentedControl.selectedSegmentIndex = 0
        case .ratio(value: _):
            segmentedControl.selectedSegmentIndex = 1
        case .constant(value: _):
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.positionConstraints.width = .offset(value: 20)
        case 1:
            attributesWrapper.attributes.positionConstraints.width = .ratio(value: 0.9)
        case 2:
            attributesWrapper.attributes.positionConstraints.width = .constant(value: 300)
        default:
            break
        }
    }
}
