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
        
        public enum AnimationType {
            case fade
            case scale(scale: CGFloat)
            case translation
            
            var isTranslation: Bool {
                return value == AnimationType.translation.value
            }
            
            var value: Int {
                switch self {
                case .fade:
                    return 0
                case .scale(scale: _):
                    return 1
                case .translation:
                    return 2
                }
            }
        }
        
        public var duration: TimeInterval
        public var types: [AnimationType]
        
        public static var `default` = Animation()
        
        public static var fade: Animation {
            return Animation(duration: 0.3, types: [.fade])
        }
        
        public static var scale: Animation {
            return Animation(duration: 0.3, types: [.scale(scale: 0.8)])
        }
        
        public static var translation: Animation {
            return Animation(duration: 0.3, types: [.translation])
        }
        
        public var containsTranslation: Bool {
            return types.contains { $0.isTranslation }
        }
        
        public init(duration: TimeInterval = 0.3, types: [AnimationType] = [.translation]) {
            self.duration = duration
            self.types = types
        }
    }
    
}
