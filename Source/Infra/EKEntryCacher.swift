//
//  EKEntryCacher.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 9/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

protocol EntryCachingHeuristic {
    var entryViews: [EKEntryView] { set get }
    var isEmpty: Bool { get }
    mutating func insert(entry: EKEntryView)
    mutating func remove(entry: EKEntryView)
    mutating func removeAll()
}

extension EntryCachingHeuristic {
    
    var isEmpty: Bool {
        return entryViews.isEmpty
    }
    
    var next: EKEntryView? {
        mutating get {
            guard let first = entryViews.first else {
                return nil
            }
            entryViews.removeFirst()
            return first
        }
    }
    
    mutating func remove(entry: EKEntryView) {
        guard let index = entryViews.index(of: entry) else {
            return
        }
        entryViews.remove(at: index)
    }
    
    mutating func removeAll() {
        entryViews.removeAll()
    }
}

struct EKEntryChronologicalCacher: EntryCachingHeuristic {
    
    // Array of entries ready for presentation
    var entryViews: [EKEntryView] = []
    
    mutating func insert(entry: EKEntryView) {
        entryViews.append(entry)
    }
}

struct EKEntryPriorityCacher: EntryCachingHeuristic {
    
    // Array of entries ready for presentation
    var entryViews: [EKEntryView] = []
    
    mutating func insert(entry: EKEntryView) {
        let entryPriority = entry.attributes.displayManner.queueOrder!.priority!
        let index = entryViews.index {
            return entryPriority <= $0.attributes.displayManner.queueOrder!.priority!
        }
        if let index = index {
            entryViews.insert(entry, at: index)
        } else {
            entryViews.append(entry)
        }
    }
}
