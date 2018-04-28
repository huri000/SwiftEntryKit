//
//  RoundCornersSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

class RoundCornersSelectionTableViewCell: SelectionTableViewCell {
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Round Corners"
        descriptionValue = "The entry's corners can be rounded in one of the following manner"
        insertSegments(by: ["None", "Top", "Bottom", "All"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.roundCorners {
        case .none:
            segmentedControl.selectedSegmentIndex = 0
        case .top(radius: _):
            segmentedControl.selectedSegmentIndex = 1
        case .bottom(radius: _):
            segmentedControl.selectedSegmentIndex = 2
        case .all(radius: _):
            segmentedControl.selectedSegmentIndex = 3
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.roundCorners = .none
        case 1:
            attributesWrapper.attributes.roundCorners = .top(radius: 10)
        case 2:
            attributesWrapper.attributes.roundCorners = .bottom(radius: 10)
        case 3:
            attributesWrapper.attributes.roundCorners = .all(radius: 10)
        default:
            break
        }
    }
}
