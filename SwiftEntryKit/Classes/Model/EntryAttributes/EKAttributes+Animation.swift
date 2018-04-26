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
        
        public struct AnimationType: OptionSet {
            public let rawValue: UInt
            public init(rawValue: UInt) {
                self.rawValue = rawValue
            }
            
            public static var fade = AnimationType(rawValue: 1)
            public static var scale = AnimationType(rawValue: 2)
            public static var translation = AnimationType(rawValue: 4)
        }
        
        public var duration: TimeInterval
        public var types: [AnimationType]
        
        public static var `default` = Animation()
        
        public static var fade: Animation {
            return Animation(duration: 0.3, types: [.fade])
        }
        
        public static var scale: Animation {
            return Animation(duration: 0.3, types: [.scale])
        }
        
        public static var translation: Animation {
            return Animation(duration: 0.3, types: [.translation])
        }
        
        public var containsTranslation: Bool {
            return types.contains(.translation)
        }
        
        public init(duration: TimeInterval = 0.3, types: [AnimationType] = [.translation]) {
            self.duration = duration
            self.types = types
        }
    }
}
