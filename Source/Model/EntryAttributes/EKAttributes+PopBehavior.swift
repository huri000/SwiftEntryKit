//
//  EKAttributes+PopBehavior.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/26/18.
//

import Foundation

public extension EKAttributes {
    
    /** Describes the entry behavior when a new entry shows (with equal or higher display-priority) */
    enum PopBehavior {
                
        /** The entry disappears promptly (Does not animates out) when a new one shows */
        case overridden
        
        /** Animate the entry out - The entry rolls out when a new one shows */
        case animated(animation: Animation)
        
        public var isOverriden: Bool {
            switch self {
            case .overridden:
                return true
            case .animated:
                return false
            }
        }
        
        var animation: Animation? {
            switch self {
            case .animated(animation: let animation):
                return animation
            case .overridden:
                return nil
            }
        }
        
        func validate() {
            #if DEBUG
            guard let animation = animation else { return }
            guard animation == .none else { return }
            print("""
            SwiftEntryKit warning: cannot associate value `EKAttributes.Animation()`
            with `EKAttributes.PopBehavior.animated`. This may result in undefined behavior.
            Please use `PopBehavior.overridden` instead.
            """)
            #endif
        }
    }
}
