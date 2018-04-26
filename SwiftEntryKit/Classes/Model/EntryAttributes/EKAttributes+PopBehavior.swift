//
//  EKAttributes+PopBehavior.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/26/18.
//

import Foundation

extension EKAttributes {
    
    /** Describes the previous entry's behavior when the current entry shows */
    public enum PopBehavior {
        
        /** Overrides the previous entry - The previous entry disappears promptly when the current one shows */
        case overriden
        
        /** Animate the previous entry - The previous entry rolls out when the current one shows.
         
         - note: This animation is applied instead of *exitAnimation* which is the default exit animation
         */
        case animated(animation: Animation)
        
        public var isOverriden: Bool {
            switch self {
            case .overriden:
                return true
            default:
                return false
            }
        }
    }
}
