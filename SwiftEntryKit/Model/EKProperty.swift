//
//  EKProperty.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKProperty {
    
    public struct ButtonContent {
        public let label: LabelContent
        public let backgroundColor: UIColor
        
        public init(label: LabelContent, backgroundColor: UIColor) {
            self.label = label
            self.backgroundColor = backgroundColor
        }
    }
    
    public struct LabelContent {
        public let text: String
        public let style: Label
        
        public init(text: String, style: Label) {
            self.text = text
            self.style = style
        }
    }
    
    public struct Label {
        public let font: UIFont
        public let color: UIColor
        
        public init(font: UIFont, color: UIColor) {
            self.font = font
            self.color = color
        }
    }
}
