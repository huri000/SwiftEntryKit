//
//  EKAttributes+Animation.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

// A protocol that describes an animation
protocol EKAnimation {
    var delay: TimeInterval { get set }
    var duration: TimeInterval { get set }
    var spring: EKAttributes.Animation.Spring? { get set }
}

// A protocol that describes a range animation
protocol EKRangeAnimation: EKAnimation {
    var start: CGFloat { get set }
    var end: CGFloat { get set }
}

public extension EKAttributes {
    
    /** Describes an animation that can be performed on the entry */
    public struct Animation {
    
        /** Describes properties for a spring animation that can be performed on the entry */
        public struct Spring {
            public let damping: CGFloat
            public let initialVelocity: CGFloat
            
            public init(damping: CGFloat, initialVelocity: CGFloat) {
                self.damping = damping
                self.initialVelocity = initialVelocity
            }
        }

        /** Describes an animation with range */
        public struct RangeAnimation: EKRangeAnimation {
            public var duration: TimeInterval
            public var delay: TimeInterval
            public var start: CGFloat
            public var end: CGFloat
            public var spring: Spring?
            
            public init(from start: CGFloat, to end: CGFloat, duration: TimeInterval, delay: TimeInterval = 0, spring: Spring? = nil) {
                self.start = start
                self.end = end
                self.delay = delay
                self.duration = duration
                self.spring = spring
            }
        }
        
        /** Describes translation animation */
        public struct Translate: EKAnimation {
            public var duration: TimeInterval
            public var delay: TimeInterval
            public var spring: Spring?

            public init(duration: TimeInterval, delay: TimeInterval = 0, spring: Spring? = nil) {
                self.delay = delay
                self.duration = duration
                self.spring = spring
            }
        }
        
        /** Translation animation prop */
        public var translate: Translate?
        
        /** Scale animation prop */
        public var scale: RangeAnimation?
        
        /** Fade animation prop */
        public var fade: RangeAnimation?
        
        public var containsTranslation: Bool {
            return translate != nil
        }
        
        public var containsScale: Bool {
            return scale != nil
        }
        
        public var containsFade: Bool {
            return fade != nil
        }
        
        public var containsAnimation: Bool {
            return containsTranslation || containsScale || containsFade
        }
        
        public var maxDelay: TimeInterval {
            return max(translate?.delay ?? 0, max(scale?.delay ?? 0, fade?.delay ?? 0))
        }
        
        public var maxDuration: TimeInterval {
            return max(translate?.duration ?? 0, max(scale?.duration ?? 0, fade?.duration ?? 0))
        }
        
        // Returns max duration + max delay
        public var totalDuration: TimeInterval {
            return maxDelay + maxDuration
        }
        
        // Class vars
        public static var translation: Animation {
            return Animation(translate: .init(duration: 0.3))
        }
        
        /** No animation at all */
        public static var none: Animation {
            return Animation()
        }
        
        public init(translate: Translate? = nil, scale: RangeAnimation? = nil, fade: RangeAnimation? = nil) {
            self.translate = translate
            self.scale = scale
            self.fade = fade
        }
    }
}
