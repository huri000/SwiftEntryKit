//
//  ScrollSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
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
        switch attributesWrapper.attributes.scroll {
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
            attributesWrapper.attributes.scroll = .enabled(swipeable: true, pullbackAnimation: .jolt)
        case 1:
            attributesWrapper.attributes.scroll = .disabled
        case 2:
            attributesWrapper.attributes.scroll = .edgeCrossingDisabled(swipeable: true)
        default:
            break
        }
    }
}
