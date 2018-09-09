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
    
    func removeEntries(by name: String)
    func removeEntries(withPriorityLowerOrEqualTo priority: EKAttributes.Precedence.Priority)
    func remove(entry: CachedEntry)
    func removeAll()
    
    func contains(entryNamed name: String) -> Bool
}

extension EntryCachingHeuristic {
    
    var isEmpty: Bool {
        return entries.isEmpty
    }
    
    func contains(entryNamed name: String) -> Bool {
        return entries.contains { $0.view.attributes.name == name }
    }
    
    func dequeue() -> CachedEntry? {
        guard let first = entries.first else {
            return nil
        }
        entries.removeFirst()
        return first
    }
    
    func removeEntries(withPriorityLowerOrEqualTo priority: EKAttributes.Precedence.Priority) {
        while let index = (entries.index { $0.view.attributes.precedence.priority <= priority }) {
            entries.remove(at: index)
        }
    }
    
    func removeEntries(by name: String) {
        while let index = (entries.index { $0.view.attributes.name == name }) {
            entries.remove(at: index)
        }
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
        let entryPriority = entry.view.attributes.precedence.priority
        let index = entries.index {
            return entryPriority > $0.view.attributes.precedence.priority
        }
        if let index = index {
            entries.insert(entry, at: index)
        } else {
            entries.append(entry)
        }
    }
}
