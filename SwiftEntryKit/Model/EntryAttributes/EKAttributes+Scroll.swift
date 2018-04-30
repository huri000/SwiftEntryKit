//
//  EKAttributes+Scroll.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/30/18.
//

import Foundation

extension EKAttributes {
    
    public enum Scroll {
        
        /** The scroll ability is totally disabled */
        case disabled
        
        /** The scroll in the opposite direction to the edge is disabled */
        case edgeCrossingDisabled(swipeable: Bool)
        
        /** The scroll abiliby is enabled */
        case enabled(swipeable: Bool, springWithDamping: Bool)
        
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
            case .edgeCrossingDisabled(swipeable: let swipeable), .enabled(swipeable: let swipeable, springWithDamping: _):
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
