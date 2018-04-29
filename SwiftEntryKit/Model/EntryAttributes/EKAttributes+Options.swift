//
//  EKAttributes+Options.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/22/18.
//

import Foundation

public extension EKAttributes {

    /** Additional options that could be applied to an *EKAttributes* instance */
    public struct Options {
        
        public enum Scroll {
            
            /** The scroll ability is totally disabled */
            case disabled
            
            /** The scroll in the opposite direction to the edge is disabled */
            case edgeCrossingDisabled
            
            /** The scroll abiliby is enabled */
            case enabled
            
            var isLooselyEnabled: Bool {
                return self != .disabled
            }
            
            var isEdgeCrossingDisabled: Bool {
                return self == .edgeCrossingDisabled
            }
        }
        
        public enum Priority {
            
            /** High priority entries can be overriden by other high priority entries only. Normal priority entries are ignored while a high priority entry is being displayed. High priority entry overrides any other entry including another high priority one */
            case high
            
            /** Normal entries can be overridden by either normal or higher priority entries. They cannot override higher priority entries and are automatically ignored when a higher priority entry is already being displayed */
            case normal
            
            var isHigh: Bool {
                return self == .high
            }
            
            func isPreceding(priority: Priority) -> Bool {
                return isHigh || (!isHigh && !priority.isHigh)
            }
        }

        /** Describes the scrolling behavior of the entry */
        public var scroll = Scroll.enabled
        
        /** Haptic notification feedback */
        public var useHapticFeedback = true
        
        /** The priority of the entry */
        public var priority = Priority.normal
    }
}
