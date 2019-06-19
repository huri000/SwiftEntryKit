//
//  EKAttributes+HomeIndicatorBehaviour.swift
//  SwiftEntryKitDemo
//
//  Created by Ruslan Timchenko on 19/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public extension EKAttributes {
    
    /** Describes the behaviour of home indicator */
    enum HomeIndicator {
        
        /** A home indicator will be always visible */
        case alwaysVisible
        
        /** There is a chance that a home indicator will be sometimes hidden */
        case autoHidden
    }
}
