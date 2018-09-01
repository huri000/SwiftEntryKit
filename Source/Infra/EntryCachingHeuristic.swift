//
//  EKEntryCacher.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 9/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

struct CachedEntry {
    let view: EKEntryView
    let presentInsideKeyWindow: Bool
    let rollbackWindow: SwiftEntryKit.RollbackWindow
}

protocol EntryCachingHeuristic: class {
    var entries: [CachedEntry] { set get }
    var isEmpty: Bool { get }
    
    func dequeue() -> CachedEntry?
    func enqueue(entry: CachedEntry)
    
    func remove(entry: CachedEntry)
    func removeAll()
}

extension EntryCachingHeuristic {
    
    var isEmpty: Bool {
        return entries.isEmpty
    }
    
    func dequeue() -> CachedEntry? {
        guard let first = entries.first else {
            return nil
        }
        entries.removeFirst()
        return first
    }
    
    func remove(entry: CachedEntry) {
        guard let index = (entries.index { $0.view == entry.view }) else {
            return
        }
        entries.remove(at: index)
    }
    
    func removeAll() {
        entries.removeAll()
    }
}

class EKEntryChronologicalQueue: EntryCachingHeuristic {
    
    var entries: [CachedEntry] = []
    
    func enqueue(entry: CachedEntry) {
        entries.append(entry)
    }
}

class EKEntryPriorityQueue: EntryCachingHeuristic {
    
    var entries: [CachedEntry] = []
    
    func enqueue(entry: CachedEntry) {
        let entryPriority = entry.view.attributes.displayManner.priority
        let index = entries.index {
            return entryPriority > $0.view.attributes.displayManner.priority
        }
        if let index = index {
            entries.insert(entry, at: index)
        } else {
            entries.append(entry)
        }
    }
}