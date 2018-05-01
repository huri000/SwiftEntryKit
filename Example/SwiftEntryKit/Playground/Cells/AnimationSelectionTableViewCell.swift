//
//  AnimationSelectionTableViewCell.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/26/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import SwiftEntryKit

class AnimationSelectionTableViewCell: SelectionTableViewCell {
    
    enum Action: String {
        case entrance
        case exit
        case pop
        
        var isOut: Bool {
            return Set([.exit, .pop]).contains(self)
        }
    }
    
    var action: Action = .entrance
    
    var animation: EKAttributes.Animation {
        set {
            switch action {
            case .entrance:
                attributesWrapper.attributes.entranceAnimation = newValue
            case .exit:
                attributesWrapper.attributes.exitAnimation = newValue
            case .pop:
                attributesWrapper.attributes.popBehavior = EKAttributes.PopBehavior.animated(animation: newValue)
            }
        }
        get {
            switch action {
            case .entrance:
                return attributesWrapper.attributes.entranceAnimation
            case .exit:
                return attributesWrapper.attributes.exitAnimation
            case .pop:
                if case EKAttributes.PopBehavior.animated(animation: let animation) = attributesWrapper.attributes.popBehavior {
                    return animation
                } else {
                    fatalError()
                }
            }
        }
    }
    
    func configure(attributesWrapper: EntryAttributeWrapper, action: Action) {
        self.action = action
        configure(attributesWrapper: attributesWrapper)
    }
    
    override func configure(attributesWrapper: EntryAttributeWrapper) {
        super.configure(attributesWrapper: attributesWrapper)
        titleValue = "\(action.rawValue.capitalized) Animation"
        descriptionValue = "Describes the \(action.rawValue) animation of the entry"
        insertSegments(by: ["Translate", "Scale", "Fade"])
        selectSegment()
    }
    
    private func selectSegment() {
        if animation.containsTranslation {
            segmentedControl.selectedSegmentIndex = 0
        } else if animation.containsScale {
            segmentedControl.selectedSegmentIndex = 1
        } else if animation.containsFade {
            segmentedControl.selectedSegmentIndex = 2
        }
    }
    
    @objc override func segmentChanged() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            animation = .translation
        case 1 where action.isOut:
            animation = .init(scale: .init(from: 1, to: 0, duration: 0.3))
        case 1:
            animation = .init(scale: .init(from: 0, to: 1, duration: 0.3))
        case 2 where action.isOut:
            animation = .init(fade: .init(from: 1, to: 0, duration: 0.3))
        case 2:
            animation = .init(fade: .init(from: 0, to: 1, duration: 0.3))
        default:
            break
        }
    }
}
