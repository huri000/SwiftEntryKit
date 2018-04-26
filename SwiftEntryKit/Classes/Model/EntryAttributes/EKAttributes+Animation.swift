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
            case fade(from: CGFloat, to: CGFloat)
            case scale(from: CGFloat, to: CGFloat)
            case translate
            
            public static var fadeDefault: AnimationType {
                return .fade(from: 0, to: 1)
            }
            
            public static var scaleDefault: AnimationType {
                return .scale(from: 0.1, to: 1)
            }
            
            public var rawValue: UInt {
                switch self {
                case .translate:
                    return 0
                case .fade(from: _, to: _):
                    return 1
                case .scale(from: _, to: _):
                    return 2
                }
            }
        }
        
        public var duration: TimeInterval
        public var types: [AnimationType]
        
        public static var `default` = Animation()
        
        public static var fade: Animation {
            return Animation(duration: 0.3, types: [.fadeDefault])
        }
        
        public static var scale: Animation {
            return Animation(duration: 0.3, types: [.scaleDefault])
        }
        
        public static var translation: Animation {
            return Animation(duration: 0.3, types: [.translate])
        }
        
        public func contains(_ type: AnimationType) -> Bool {
            return types.contains { type.rawValue == $0.rawValue }
        }
        
        public var scale: AnimationType? {
            return types.filter { AnimationType.scaleDefault.rawValue == $0.rawValue }.first
        }
        
        public var fade: AnimationType? {
            return types.filter { AnimationType.fadeDefault.rawValue == $0.rawValue }.first
        }
        
        public var containsTranslation: Bool {
            return contains(.translate)
        }
        
        public var containsScale: Bool {
            return contains(AnimationType.scaleDefault)
        }
        
        public var containsFade: Bool {
            return contains(AnimationType.fadeDefault)
        }
        
        public init(duration: TimeInterval = 0.3, types: [AnimationType] = [.translate]) {
            self.duration = duration
            self.types = types
        }
    }
}
