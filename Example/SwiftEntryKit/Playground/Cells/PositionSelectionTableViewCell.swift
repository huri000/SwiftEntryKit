//
//  LocationSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

class PositionSelectionTableViewCell: SelectionTableViewCell {
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Position"
        descriptionValue = "The position of the entry inside the screen"
        insertSegments(by: ["Top", "Bottom", "Center"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.position {
        case .top:
            segmentedControl.selectedSegmentIndex = 0
        case .bottom:
            segmentedControl.selectedSegmentIndex = 1
        case .center:
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.position = .top
        case 1:
            attributesWrapper.attributes.position = .bottom
        case 2:
            attributesWrapper.attributes.position = .center
        default:
            break
        }
    }
}
