//
//  EKAttributes+DisplayMode.swift
//  SwiftEntryKit
//
//  Created by Daniel on 26/07/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

public extension EKAttributes {
    
    /** Display mode for the entry */
    enum DisplayMode {
        
        /** The display mode is inferred from the current user interface style */
        case inferred
        
        /** The display mode is light */
        case light
        
        /** The display mode is dark */
        case dark
    }
}
