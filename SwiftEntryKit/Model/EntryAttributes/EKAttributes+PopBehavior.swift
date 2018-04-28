//
//  EKAttributes+PopBehavior.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/26/18.
//

import Foundation

extension EKAttributes {
    
    /** Describes the entry behavior when a new entry shows */
    public enum PopBehavior {
        
        /** The entry disappears promptly when a new one shows */
        case overriden
        
        /** Animate the entry out - The entry rolls out when a new one shows */
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
