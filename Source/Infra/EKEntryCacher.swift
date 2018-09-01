//
//  EKEntryCacher.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 9/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

protocol EntryCachingHeuristic: class {
    var entryViews: [EKEntryView] { set get }
    var isEmpty: Bool { get }
    func insert(entry: EKEntryView)
    func remove(entry: EKEntryView)
    func removeAll()
}

extension EntryCachingHeuristic {
    
    var isEmpty: Bool {
        return entryViews.isEmpty
    }
    
    var next: EKEntryView? {
        guard let first = entryViews.first else {
            return nil
        }
        entryViews.removeFirst()
        return first
    }
    
    func remove(entry: EKEntryView) {
        guard let index = entryViews.index(of: entry) else {
            return
        }
        entryViews.remove(at: index)
    }
    
    func removeAll() {
        entryViews.removeAll()
    }
}

class EKEntryChronologicalCacher: EntryCachingHeuristic {
    
    // Array of entries ready for presentation
    var entryViews: [EKEntryView] = []
    
    func insert(entry: EKEntryView) {
        entryViews.append(entry)
    }
}

class EKEntryPriorityCacher: EntryCachingHeuristic {
    
    // Array of entries ready for presentation
    var entryViews: [EKEntryView] = []
    
    func insert(entry: EKEntryView) {
        let entryPriority = entry.attributes.displayManner.priority
        let index = entryViews.index {
            return entryPriority <= $0.attributes.displayManner.priority
        }
        if let index = index {
            entryViews.insert(entry, at: index)
        } else {
            entryViews.append(entry)
        }
    }
}
