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

    /** The shadow around the entry */
    public enum Shadow {
        
        /** No shadow */
        case none
        
        /** Shadow with value */
        case active(with: Value)
        
        /** The shadow properties */
        public struct Value {
            public let radius: CGFloat
            public let opacity: Float
            public let color: UIColor
            public let offset: CGSize
            
            public init(color: UIColor = .black, opacity: Float, radius: CGFloat, offset: CGSize = .zero) {
                self.color = color
                self.radius = radius
                self.offset = offset
                self.opacity = opacity
            }
        }
    }
}


