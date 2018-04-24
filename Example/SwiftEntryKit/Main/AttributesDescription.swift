//
//  AttributesDescription.swift
//  SwiftEntryKit_Example
//
//  Created by Daniel Huri on 4/24/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import SwiftEntryKit

class EntryAttributesDescription {
    
    var title = ""
    let attributes: EKAttributes
    
    init(with attributes: EKAttributes, title: String = "") {
        self.title = title
        self.attributes = attributes
    }
    
    var description: String {
        let title = "The entry is located at the \(position), \(windowLevel), and displayed for \(displayDuration).\n\nIt's background has a \(entryBackground), the screen's background has a \(screenBackground).\n\nTouchs on the entry \(entryInteraction) and touchs on the screen \(screenInteraction)"
        return title
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
            return "above the status bar"
        case .belowStatusBar:
            return "below the status bar"
        case .custom(level: let level):
            return "the window level is \(level)"
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
        case .disabled:
            desc += "are disabled - touchs go through into the lower level window"
        }
        return desc
    }
    
    private func background(byStyle style: EKAttributes.BackgroundStyle) -> String {
        var desc = ""
        switch style {
        case .visualEffect(style: _):
            desc += "blur effect"
        case .color(color: _):
            desc += "custom color"
        case .image(image: _):
            desc += "custom image"
        case .gradient(gradient: _):
            desc += "gradient colors"
        case .none:
            desc = "clear style"
        }
        return desc
    }
}
