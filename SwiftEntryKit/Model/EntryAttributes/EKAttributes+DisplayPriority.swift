//
//  EKAttributes+DisplayPriority.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/29/18.
//

import Foundation

public extension EKAttributes {
 
    /** The display priority of the entry - Determines whether is can be overriden by other entries */
    public enum DisplayPriority {
        
        /** High priority entries can be overriden by other high priority entries only. Normal priority entries are ignored while a high priority entry is being displayed. High priority entry overrides any other entry including another high priority one */
        case high
        
        /** Normal entries can be overridden by either normal or higher priority entries. They cannot override higher priority entries and are automatically ignored when a higher priority entry is already being displayed */
        case normal
        
        var isHigh: Bool {
            return self == .high
        }
        
        func isPreceding(priority: DisplayPriority) -> Bool {
            return isHigh || (!isHigh && !priority.isHigh)
        }
    }
}
