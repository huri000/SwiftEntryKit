//
//  EKAttributes+Animation.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    public struct Animation {
    
        public struct Spring {
            public let damping: CGFloat
            public let initialVelocity: CGFloat
            
            init(damping: CGFloat, initialVelocity: CGFloat) {
                self.damping = damping
                self.initialVelocity = initialVelocity
            }
        }

        public struct Scale {
            public let start: CGFloat
            public let end: CGFloat
            public let delay: TimeInterval
            public let duration: TimeInterval
            public let spring: Spring?
            
            public init(from start: CGFloat, to end: CGFloat, duration: TimeInterval, delay: TimeInterval = 0, spring: Spring? = nil) {
                self.start = start
                self.end = end
                self.delay = delay
                self.duration = duration
                self.spring = spring
            }
        }
        
        public struct Fade {
            public let start: CGFloat
            public let end: CGFloat
            public let delay: TimeInterval
            public let duration: TimeInterval
            
            public init(from start: CGFloat, to end: CGFloat, duration: TimeInterval, delay: TimeInterval = 0) {
                self.start = start
                self.end = end
                self.delay = delay
                self.duration = duration
            }
        }
        
        public struct Translate {
            public let delay: TimeInterval
            public let duration: TimeInterval
            public let spring: Spring?

            public init(duration: TimeInterval, delay: TimeInterval = 0, spring: Spring? = nil) {
                self.delay = delay
                self.duration = duration
                self.spring = spring
            }
        }
        
        // Instance vars
        public var scale: Scale?
        public var translate: Translate?
        public var fade: Fade?
        
        public var containsTranslation: Bool {
            return translate != nil
        }
        
        public var containsScale: Bool {
            return scale != nil
        }
        
        public var containsFade: Bool {
            return fade != nil
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
        public static var translate: Animation {
            return Animation(translate: .init(duration: 0.3))
        }
        
        // Init
        public init(translate: Translate? = nil, scale: Scale? = nil, fade: Fade? = nil) {
            self.translate = translate
            self.scale = scale
            self.fade = fade
        }
    }
}
