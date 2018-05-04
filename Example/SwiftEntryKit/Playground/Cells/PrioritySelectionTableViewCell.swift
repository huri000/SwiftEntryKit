//
//  PrioritySelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/29/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class PrioritySelectionTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Display Priority"
        descriptionValue = "The priority of the entry. *Max* overrides any other entry. *Normal* overrides only other normal priority entry"
        insertSegments(by: ["Normal", "High", "Max"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.displayPriority {
        case .normal:
            segmentedControl.selectedSegmentIndex = 0
        case .high:
            segmentedControl.selectedSegmentIndex = 1
        case .max:
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.displayPriority = .normal
        case 1:
            attributesWrapper.attributes.displayPriority = .high
        case 2:
            attributesWrapper.attributes.displayPriority = .max
        default:
            break
        }
    }
}
