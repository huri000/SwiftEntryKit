//
//  EKAttributes+WindowLevel.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    /** Describes the window level in which the entry would be displayed */
    public enum WindowLevel {
        
        /** Above the alerts */
        case alerts
        
        /** Above the status bar */
        case statusBar
        
        /** Above the application window */
        case normal
        
        /** Custom level */
        case custom(level: UIWindowLevel)
        
        /** Returns the raw value - the window level itself */
        public var value: UIWindowLevel {
            switch self {
            case .alerts:
                return UIWindowLevelAlert
            case .statusBar:
                return UIWindowLevelStatusBar
            case .normal:
                return UIWindowLevelNormal
            case .custom(level: let level):
                return level
            }
        }
    }
}
