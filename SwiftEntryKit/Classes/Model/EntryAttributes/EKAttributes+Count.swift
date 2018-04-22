//
//  EKAttributes+Count.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/22/18.
//

import Foundation

public extension EKAttributes {
    
    /** Counts the active entries. When 0, no entry is presented. */
    public internal(set) static var count: UInt = 0
    
    /** *true* when at least 1 entry is presented */
    public static var isPresenting: Bool {
        return count > 0
    }
}
