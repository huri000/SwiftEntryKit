//
//  EKAttributes+Shadow.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation

public extension EKAttributes {
    
    /** Shadow attributes */
    public struct Shadow {
        public var radius: CGFloat
        public var opacity: CGFloat
        public var color: UIColor
        public var offset: CGPoint
        
        public init(color: UIColor = .black, opacity: CGFloat, radius: CGFloat, offset: CGPoint) {
            self.color = color
            self.radius = radius
            self.offset = offset
            self.opacity = opacity
        }
    }
    
    public struct Corners { }
}


