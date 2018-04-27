//
//  WindowLevelTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class WindowLevelTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Window Level"
        descriptionValue = "Where the entry should be presented in the application window hierarchy"
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
