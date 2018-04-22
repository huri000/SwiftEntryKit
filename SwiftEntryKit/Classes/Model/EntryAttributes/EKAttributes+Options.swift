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
        public var scroll = Scroll.edgeCrossingDisabled
        
        /**
         Whether the entry should override the previous entry that is currently presented.
         If 'true', the previous entry disappears immediately leaving vacant space to the current entry.
         If 'false', the previous entry rolls out animatedly.
         
         - note: See *rollOutAdditionalAnimation* and *exitAnimation* for exit animation.
         */
        public var overridesPreviousEntry = false
        
        /** Signals the presentor to consider or ignore safe area.
         Can be used to present content outside the safe area margins such as on the notch of the iPhone X or the status bar itself. */
        public var ignoreSafeArea = false
    }
}
