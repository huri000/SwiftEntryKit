//
//  EKAttributes+Count.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/22/18.
//

import Foundation

extension EKAttributes {
    
    /** Counts the active entries. When 0, no entry is presented. */
    static var count: UInt = 0
    
    /** *true* when at least 1 entry is presented */
    static var isDisplaying: Bool {
        return count > 0
    }
}
