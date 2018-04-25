//
//  WindowLevelTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class WindowLevelTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Window Level"
        descriptionValue = "The window level of the entry"
        insertSegments(by: ["Above status bar", "Below status bar"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.windowLevel {
        case .aboveStatusBar:
            segmentedControl.selectedSegmentIndex = 0
        case .belowStatusBar:
            segmentedControl.selectedSegmentIndex = 1
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.windowLevel = .aboveStatusBar
        case 1:
            attributesWrapper.attributes.windowLevel = .belowStatusBar
        default:
            break
        }
    }
}
