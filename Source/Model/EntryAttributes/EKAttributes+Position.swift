//
//  EKAttributes+Position.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

public extension EKAttributes {

    /** The position of the entry. */
    enum Position {
        
        /** The entry appears at the top of the screen. */
        case top
        
        /** The entry appears at the bottom of the screen. */
        case bottom
        
        /** The entry appears at the center of the screen. */
        case center
        
        public var isTop: Bool {
            return self == .top
        }
        
        public var isCenter: Bool {
            return self == .center
        }
        
        public var isBottom: Bool {
            return self == .bottom
        }
    }
}
