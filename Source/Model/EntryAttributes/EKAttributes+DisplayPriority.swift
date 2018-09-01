//
//  EKAttributes+Priority.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/29/18.
//

import Foundation

fileprivate extension Int {
    var isValidDisplayPriority: Bool {
        return self >= EKAttributes.DisplayManner.Priority.minRawValue && self <= EKAttributes.DisplayManner.Priority.maxRawValue
    }
}

public extension EKAttributes {
    
    public enum DisplayManner {
        
        public enum Order {
            case chronological
            case priority(value: Priority)
            
            public var priority: Priority? {
                if case .priority(value: let priority) = self {
                    return priority
                }
                return nil
            }
        }
        
        /** The display priority of the entry - Determines whether is can be overriden by other entries.
         Must be in range [0...1000] */
        public struct Priority : Hashable, Equatable, RawRepresentable, Comparable {
            public var rawValue: Int
            
            public var hashValue: Int {
                return rawValue
            }
            
            public init(_ rawValue: Int) {
                assert(rawValue.isValidDisplayPriority, "Display Priority must be in range [\(Priority.minRawValue)...\(Priority.maxRawValue)]")
                self.rawValue = rawValue
            }
            
            public init(rawValue: Int) {
                assert(rawValue.isValidDisplayPriority, "Display Priority must be in range [\(Priority.minRawValue)...\(Priority.maxRawValue)]")
                self.rawValue = rawValue
            }
            
            public static func == (lhs: Priority, rhs: Priority) -> Bool {
                return lhs.rawValue == rhs.rawValue
            }
            
            public static func < (lhs: Priority, rhs: Priority) -> Bool {
                return lhs.rawValue < rhs.rawValue
            }
        }
        
        case override(priority: Priority)
        case enqueued(order: Order)
        
        public var queueOrder: Order? {
            if case .enqueued(order: let order) = self {
                return order
            }
            return nil
        }
    }
}

/** High priority entries can be overriden by other equal or higher priority entries only.
 Entries are ignored as a higher priority entry is being displayed.
 High priority entry overrides any other entry including another equal priority one.
 You can you on of the values (.max, high, normal, low, min) and also set your own values. */
public extension EKAttributes.DisplayManner.Priority {
    
    public static let maxRawValue = 1000
    public static let highRawValue = 750
    public static let normalRawValue = 500
    public static let lowRawValue = 250
    public static let minRawValue = 0

    /** Max - the highest possible priority of an entry. Can override only entries with *max* priority */
    public static let max = EKAttributes.DisplayManner.Priority(rawValue: maxRawValue)
    public static let high = EKAttributes.DisplayManner.Priority(rawValue: highRawValue)
    public static let normal = EKAttributes.DisplayManner.Priority(rawValue: normalRawValue)
    public static let low = EKAttributes.DisplayManner.Priority(rawValue: lowRawValue)
    public static let min = EKAttributes.DisplayManner.Priority(rawValue: minRawValue)
}

