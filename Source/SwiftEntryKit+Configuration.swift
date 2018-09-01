//
//  SwiftEntryKit+Configuration.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 9/1/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

public extension SwiftEntryKit {
    
    public struct Configuration {
        
        public enum EntryQueueOrder {
            case chronological
            case priority
            
            var cachingHeuristic: EntryCachingHeuristic {
                switch self {
                case .chronological:
                    return EKEntryChronologicalCacher()
                case .priority:
                    return EKEntryPriorityCacher()
                }
            }
        }
        
        public var entryQueueOrder = EntryQueueOrder.chronological
        public var usesKeyWindowForPresentation = false
    }
}
