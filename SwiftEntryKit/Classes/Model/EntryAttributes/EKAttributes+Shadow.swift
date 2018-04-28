//
//  EKAttributes+Shadow.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import Foundation
import UIKit

public extension EKAttributes {

    public enum Shadow {
        case none
        case active(with: Value)
        
        /** Shadow attributes */
        public struct Value {
            public var radius: CGFloat
            public var opacity: Float
            public var color: UIColor
            public var offset: CGSize
            
            public init(color: UIColor = .black, opacity: Float, radius: CGFloat, offset: CGSize) {
                self.color = color
                self.radius = radius
                self.offset = offset
                self.opacity = opacity
            }
        }
    }
}


