//
//  EKAttributes+DisplayPriority.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/29/18.
//

import Foundation

fileprivate extension Float {
    var isValidDisplayPriority: Bool {
        return self >= EKAttributes.DisplayPriority.minRawValue && self <= EKAttributes.DisplayPriority.maxRawValue
    }
}

public extension EKAttributes {
 
    /** The display priority of the entry - Determines whether is can be overriden by other entries.
     Must be in range [0...1000] */
    public struct DisplayPriority : Equatable, RawRepresentable, Comparable {
        fileprivate static let minRawValue: Float = 0
        fileprivate static let maxRawValue: Float = 1000
        
        public var rawValue: Float
        
        public init(_ rawValue: Float) {
            assert(rawValue.isValidDisplayPriority, "Display Priority must be in range [\(DisplayPriority.minRawValue)...\(DisplayPriority.maxRawValue)]")
            self.rawValue = rawValue
        }
        
        public init(rawValue: Float) {
            assert(rawValue.isValidDisplayPriority, "Display Priority must be in range [\(DisplayPriority.minRawValue)...\(DisplayPriority.maxRawValue)]")
            self.rawValue = rawValue
        }
        
        public static func < (lhs: DisplayPriority, rhs: DisplayPriority) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }
}

/** High priority entries can be overriden by other equal or higher priority entries only.
 Entries are ignored as a higher priority entry is being displayed.
 High priority entry overrides any other entry including another equal priority one.
 You can you on of the values (.max, high, normal, low, min) and also set your own values. */
public extension EKAttributes.DisplayPriority {
    
    /** Max - the highest possible priority of an entry. Can override only entries with *max* priority */
    public static let max = EKAttributes.DisplayPriority(rawValue: 1000)
    public static let high = EKAttributes.DisplayPriority(rawValue: 750)
    public static let normal = EKAttributes.DisplayPriority(rawValue: 500)
    public static let low = EKAttributes.DisplayPriority(rawValue: 250)
    public static let min = EKAttributes.DisplayPriority(rawValue: 0)
}

