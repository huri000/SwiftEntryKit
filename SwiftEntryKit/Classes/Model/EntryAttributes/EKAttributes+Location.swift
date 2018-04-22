//
//  EKAttributes+Location.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

public extension EKAttributes {

    /** The location of the entry. */
    public enum Location {
        
        /** The entry appears at the top of the screen. */
        case top
        
        /** The entry appears at the bottom of the screen. */
        case bottom
        
        var isTop: Bool {
            return self == .top
        }
    }
}
