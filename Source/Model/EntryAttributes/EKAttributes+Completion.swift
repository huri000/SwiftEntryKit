//
//  EKAttributes+Completion.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 6/16/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation

extension EKAttributes {

    public struct LifecycleActions {
        
        public typealias Action = () -> Void

        /** Executed before the entry appears - before the animation starts.
         Might not get called in case another entry with a higher display priority is displayed.
         */
        public var willAppear: Action?
        
        /** Executed after the animation ends.
         Might not get called in case another entry with a higher display priority is displayed.
         */
        public var didAppear: Action?

        /** Executed before the entry disappears (Before the animation starts) */
        public var willDisappear: Action?
        
        /** Executed after the entry disappears (After the animation ends) */
        public var didDisappear: Action?
        
        public init(willAppear: Action? = nil, didAppear: Action? = nil, willDisappear: Action? = nil, didDisappear: Action? = nil) {
            self.willAppear = willAppear
            self.didAppear = didAppear
            self.willDisappear = willDisappear
            self.didDisappear = didDisappear
        }
    }
}
