//
//  EKAttributes+Frame.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/21/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public extension EKAttributes {
    
    public struct Frame {
        public var verticalOffset: CGFloat
        public var horizontalOffset: CGFloat
        public var cornerRadius: CGFloat
        
        public init(verticalOffset: CGFloat = 10, horizontalOffset: CGFloat = 16, cornerRadius: CGFloat = 10) {
            self.verticalOffset = verticalOffset
            self.horizontalOffset = horizontalOffset
            self.cornerRadius = cornerRadius
        }
    }
}
