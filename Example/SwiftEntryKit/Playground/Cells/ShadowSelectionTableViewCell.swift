//
//  ShadowSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

class ShadowSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Drop Shadow"
        descriptionValue = "A drop shadow effect that can be applied to the entry"
        insertSegments(by: ["Off", "On"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.shadow {
        case .none:
            segmentedControl.selectedSegmentIndex = 0
        case .active(with: _):
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.shadow = .none
        case 1:
            let value = EKAttributes.Shadow.Value(color: .black, opacity: 0.5, radius: 10, offset: .zero)
            attributesWrapper.attributes.shadow = .active(with: value)
        default:
            break
        }
    }
}
