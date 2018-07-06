//
//  EKAttributes+Scroll.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/30/18.
//

import Foundation

public extension EKAttributes {
    
    /** Describes the event of scroll user interaction */
    public enum Scroll {
    
        /** Describes the event when the user leaves the entry after rubber-banding it - How the entry behaves */
        public struct PullbackAnimation {
            public var duration: TimeInterval
            public var damping: CGFloat
            public var initialSpringVelocity: CGFloat
            
            public init(duration: TimeInterval, damping: CGFloat, initialSpringVelocity: CGFloat) {
                self.duration = duration
                self.damping = damping
                self.initialSpringVelocity = initialSpringVelocity
            }
            
            /** The entry is jolted when it's pulled back into the original position */
            public static var jolt: PullbackAnimation {
                return PullbackAnimation(duration: 0.5, damping: 0.3, initialSpringVelocity: 10)
            }
            
            /** The view eases out when it's pulled back into the original position */
            public static var easeOut: PullbackAnimation {
                return PullbackAnimation(duration: 0.3, damping: 1, initialSpringVelocity: 10)
            }
        }
        
        /** The scroll ability is totally disabled */
        case disabled
        
        /** The scroll in the opposite direction to the edge is disabled */
        case edgeCrossingDisabled(swipeable: Bool)
        
        /** The scroll abiliby is enabled */
        case enabled(swipeable: Bool, pullbackAnimation: PullbackAnimation)
        
        var isEnabled: Bool {
            switch self {
            case .disabled:
                return false
            default:
                return true
            }
        }
        
        var isSwipeable: Bool {
            switch self {
            case .edgeCrossingDisabled(swipeable: let swipeable), .enabled(swipeable: let swipeable, pullbackAnimation: _):
                return swipeable
            default:
                return false
            }
        }
        
        var isEdgeCrossingEnabled: Bool {
            switch self {
            case .edgeCrossingDisabled:
                return false
            default:
                return true
            }
        }
    }
}
