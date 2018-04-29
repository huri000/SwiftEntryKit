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
        
        /** Describes the scrolling behavior of the entry */
        public var scroll = Scroll.enabled
        
        /** Haptic notification feedback */
        public var useHapticFeedback = true
    }
}
