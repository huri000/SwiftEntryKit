//
//  ScreenBackgroundStyleSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/25/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import SwiftEntryKit

final class BackgroundStyleSelectionTableViewCell: SelectionTableViewCell {
    
    private var focus: Focus = .entry
    
    private var backgroundStyle: EKAttributes.BackgroundStyle {
        get {
            switch focus {
            case .entry:
                return attributesWrapper.attributes.entryBackground
            case .screen:
                return attributesWrapper.attributes.screenBackground
            }
        }
        set {
            switch focus {
            case .entry:
                attributesWrapper.attributes.entryBackground = newValue
            case .screen:
                attributesWrapper.attributes.screenBackground = newValue
            }
        }
    }
    
    func configure(attributesWrapper: EntryAttributeWrapper, focus: Focus) {
        self.focus = focus
        configure(attributesWrapper: attributesWrapper)
    }
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "\(focus.rawValue.capitalized) Background Style"
        descriptionValue = "The style of the \(focus.rawValue)'s background can be one of the following options"
        insertSegments(by: ["Clear", "Blur", "Gradient", "Color"])
        selectSegment()
    }
    
    private func selectSegment() {
        switch backgroundStyle {
        case .clear:
            segmentedControl.selectedSegmentIndex = 0
        case .visualEffect(style: _):
            segmentedControl.selectedSegmentIndex = 1
        case .gradient(gradient: _):
            segmentedControl.selectedSegmentIndex = 2
        case .color(color: _):
            segmentedControl.selectedSegmentIndex = 3
        default:
            // TODO: Image isn't handled yet
            break
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            backgroundStyle = .clear
        case 1:
            backgroundStyle = .visualEffect(style: .standard)
        case 2:
            let gradient = EKAttributes.BackgroundStyle.Gradient(
                colors: [Color.BlueGray.c100, Color.BlueGray.c300],
                startPoint: .zero,
                endPoint: CGPoint(x: 1, y: 1)
            )
            backgroundStyle = .gradient(gradient: gradient)
        case 3:
            let color: EKColor
            switch focus {
            case .entry:
                color = .amber
            case .screen:
                color = EKColor.black.with(alpha: 0.5)
            }
            backgroundStyle = .color(color: color)
        default:
            break
        }
    }
}

