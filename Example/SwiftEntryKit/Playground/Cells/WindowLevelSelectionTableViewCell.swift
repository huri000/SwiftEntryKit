//
//  WindowLevelTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

class WindowLevelSelectionTableViewCell: SelectionTableViewCell {

    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "Window Level"
        descriptionValue = "Where the entry should be displayed in the application window hierarchy"
        insertSegments(by: ["Normal", "Status Bar", "Alerts"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch attributesWrapper.attributes.windowLevel {
        case .normal:
            segmentedControl.selectedSegmentIndex = 0
        case .statusBar:
            segmentedControl.selectedSegmentIndex = 1
        case .alerts:
            segmentedControl.selectedSegmentIndex = 2
        default:
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            attributesWrapper.attributes.windowLevel = .normal
        case 1:
            attributesWrapper.attributes.windowLevel = .statusBar
        case 2:
            attributesWrapper.attributes.windowLevel = .alerts
        default:
            break
        }
    }
}
