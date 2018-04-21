//
//  EKAttributes+WindowLevel.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    // Describes the level in which the entry would be presented
    public enum WindowLevel {
        case aboveStatusBar
        case belowStatusBar
        case custom(level: UIWindowLevel)
        
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
