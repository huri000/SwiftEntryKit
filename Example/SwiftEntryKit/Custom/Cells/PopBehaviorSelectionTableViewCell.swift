//
//  ExitBehaviorSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SwiftEntryKit

class PopBehaviorSelectionTableViewCell: SelectionTableViewCell {
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Pop Behavior"
        descriptionValue = "Specifies how the entry pops out as the next entry is pushed in"
        insertSegments(by: ["Overriden", "Animated"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.options.popBehavior {
        case .overriden:
            segmentedControl.selectedSegmentIndex = 0
        case .animated(animation: _):
            segmentedControl.selectedSegmentIndex = 1
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.options.popBehavior = .overriden
        case 1:
            let animation = EKAttributes.Animation(duration: 0.6, types: [.scaleDefault])
            attributesWrapper.attributes.options.popBehavior = .animated(animation: animation)
        default:
            break
        }
    }
}
