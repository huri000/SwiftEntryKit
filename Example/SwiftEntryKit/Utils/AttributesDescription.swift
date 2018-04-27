//
//  AttributesDescription.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SwiftEntryKit

class EntryAttributesDescription {
    
    let title: String
    var description: String
    let attributes: EKAttributes
    
    init(with attributes: EKAttributes, title: String, description: String = "") {
        self.title = title
        self.description = description
        self.attributes = attributes
    }

    var type: String {
        if attributes.positionConstraints.hasVerticalOffset {
            return "float"
        } else {
            return "toast"
        }
    }
    
    var position: String {
        if attributes.position.isTop {
            return "top"
        } else {
            return "bottom"
        }
    }
    
    var windowLevel: String {
        switch attributes.windowLevel {
        case .aboveStatusBar:
            return "above the status bar window"
        case .belowStatusBar:
            return "below the status bar window"
        case .custom(level: let level):
            return "at window level \(level)"
        }
    }
    
    var displayDuration: String {
        let duration = attributes.displayDuration == .infinity ? "an infinate duration" : "\(attributes.displayDuration)s"
        return "\(duration)"
    }
    
    var entryBackground: String {
        return background(byStyle: attributes.entryBackground)
    }
    
    var screenBackground: String {
        return background(byStyle: attributes.screenBackground)
    }
    
    var screenInteraction: String {
        return interaction(byValue: attributes.screenInteraction)
    }
    
    var entryInteraction: String {
        return interaction(byValue: attributes.entryInteraction)
    }
    
    // MARK: Private

    private func interaction(byValue value: EKAttributes.UserInteraction) -> String {
        var desc = ""
        switch value.defaultAction {
        case .absorbTouches:
            desc += "are absorbed - does nothing"
        case .delayExit(by: let time):
            desc += "delays the entry dismissal by \(time)s"
        case .dismissEntry:
            desc += "dismiss the entry immediately"
        case .forward:
            desc += "go through into the lower level window"
        }
        return desc
    }
    
    private func background(byStyle style: EKAttributes.BackgroundStyle) -> String {
        var desc = ""
        switch style {
        case .visualEffect(style: _):
            desc += "blurred"
        case .color(color: _):
            desc += "colored"
        case .image(image: _):
            desc += "image"
        case .gradient(gradient: _):
            desc += "gradient"
        case .clear:
            desc = "clear"
        }
        return desc
    }
}
