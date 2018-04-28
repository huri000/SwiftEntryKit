//
//  EKAttributes+WindowLevel.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    /** Describes the window level in which the entry would be presented */
    public enum WindowLevel {
        
        /** One level above the status bar */
        case aboveStatusBar
        
        /** One level below the status bar */
        case belowStatusBar
        
        /** Custom level */
        case custom(level: UIWindowLevel)
        
        /** Returns the raw value - the window level */
        public var value: UIWindowLevel {
            switch self {
            case .aboveStatusBar:
                return UIWindowLevelStatusBar + 1
            case .belowStatusBar:
                return UIWindowLevelStatusBar - 1
            case .custom(level: let level):
                return level
            }
        }
    }
}
