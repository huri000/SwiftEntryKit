//
//  LocationSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import SwiftEntryKit

class PositionSelectionTableViewCell: SelectionTableViewCell {
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Position"
        descriptionValue = "The position of the entry inside the screen"
        insertSegments(by: ["Top", "Bottom"])
        selectSegment()
    }
    
    private func selectSegment() {
        if attributesWrapper.attributes.position.isTop {
            segmentedControl.selectedSegmentIndex = 0
        } else {
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.position = .top
        case 1:
            attributesWrapper.attributes.position = .bottom
        default:
            break
        }
    }
}
