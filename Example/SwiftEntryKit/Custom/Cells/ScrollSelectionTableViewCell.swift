//
//  ScrollSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class ScrollSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Scroll Behavior"
        descriptionValue = "Describes whether the entry is vertically scrollable"
        insertSegments(by: ["Loosed", "Disabled", "One Side"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.options.scroll {
        case .enabled:
            segmentedControl.selectedSegmentIndex = 0
        case .disabled:
            segmentedControl.selectedSegmentIndex = 1
        case .edgeCrossingDisabled:
            segmentedControl.selectedSegmentIndex = 2
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.options.scroll = .enabled
        case 1:
            attributesWrapper.attributes.options.scroll = .disabled
        case 2:
            attributesWrapper.attributes.options.scroll = .edgeCrossingDisabled
        default:
            break
        }
    }
}
