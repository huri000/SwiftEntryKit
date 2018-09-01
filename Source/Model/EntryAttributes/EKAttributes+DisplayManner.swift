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
    
    /**
     Describes the manner on which the entry is pushed and displayed.
     See the various values of more explanation.
     */
    public enum DisplayManner {
        
        /**
         The display priority of the entry - Determines whether is can be overriden by other entries.
         Must be in range [0...1000]
         */
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
        
        /**
         Describes the queueing heoristic of entries
         */
        public enum QueueingHeuristic {
            
            /** Determines the heuristic which the entry-queue is based on */
            public static var value = QueueingHeuristic.chronological
            
            /** Chronological - FIFO */
            case chronological
            
            /** Ordered by priority */
            case priority
            
            /** Returns the caching heuristics - The machanism that determines the order of queue */
            var heuristic: EntryCachingHeuristic {
                switch self {
                case .chronological:
                    return EKEntryChronologicalQueue()
                case .priority:
                    return EKEntryPriorityQueue()
                }
            }
        }
        
        /**
         Describes an *overriding* behavior for a new entry.
         - In case no previous entry that is presented - display the new entry.
         - In case there is an entry that is presented - override it using the new entry. Also optionally drop all previously enqueue entries, if there are any.
         */
        case override(priority: Priority, dropEnqueuedEntries: Bool)
        
        /**
         Describes FIFO behavior for entry presentation.
         - In case no previous entry that is presented - display the new entry.
         - In case there is an entry that is presented - enqueue the new entry.
         */
        case enqueue(priority: Priority)
        
        /** Setter / Getter for the display priority */
        public var priority: Priority {
            set {
                switch self {
                case .enqueue(priority: _):
                    self = .enqueue(priority: newValue)
                case .override(priority: _, dropEnqueuedEntries: let dropEnqueuedEntries):
                    self = .override(priority: newValue, dropEnqueuedEntries: dropEnqueuedEntries)
                }
            }
            get {
                switch self {
                case .enqueue(priority: let priority):
                    return priority
                case .override(priority: let priority, dropEnqueuedEntries: _):
                    return priority
                }
            }
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

