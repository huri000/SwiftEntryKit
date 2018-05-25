//
//  EKProperty.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 4/19/18.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

public struct EKProperty {
    
    /** Button content descriptor */
    public struct ButtonContent {
        
        public typealias Action = () -> ()
        
        /** Button's title label content descriptor */
        public var label: LabelContent
        
        /** Button's background color */
        public var backgroundColor: UIColor
        public var highlightedBackgroundColor: UIColor

        /** Action */
        public var action: Action?
        
        public init(label: LabelContent, backgroundColor: UIColor, highlightedBackgroundColor: UIColor, action: @escaping Action = {}) {
            self.label = label
            self.backgroundColor = backgroundColor
            self.highlightedBackgroundColor = highlightedBackgroundColor
            self.action = action
        }
    }
    
    /** Label content descriptor */
    public struct LabelContent {
        
        /** The text */
        public var text: String
        
        /** The label's style */
        public var style: LabelStyle
        
        public init(text: String, style: LabelStyle) {
            self.text = text
            self.style = style
        }
    }
    
    /** Label style descriptor */
    public struct LabelStyle {
        
        /** Font of the text */
        public var font: UIFont
        
        /** Color of the text */
        public var color: UIColor
        
        /** Text Alignment */
        public var alignment: NSTextAlignment
        
        public init(font: UIFont, color: UIColor, alignment: NSTextAlignment = .left) {
            self.font = font
            self.color = color
            self.alignment = alignment
        }
    }
    
    /** Image View style descriptor */
    public struct ImageContent {
        
        /** The image */
        public var image: UIImage
        
        /** Image View size - can be forced. If nil, then the image view hugs content and resists compression */
        public var size: CGSize?
    
        /** Content mode */
        public var contentMode: UIViewContentMode
        
        /** Shuld the image can rounded */
        public var makeRound: Bool
    
        public init(image: UIImage, size: CGSize? = nil, contentMode: UIViewContentMode = .scaleToFill, makeRound: Bool = false) {
            self.image = image
            self.size = size
            self.contentMode = contentMode
            self.makeRound = makeRound
        }
        
        public init(imageName: String, size: CGSize? = nil, contentMode: UIViewContentMode = .scaleToFill, makeRound: Bool = false) {
            self.init(image: UIImage(named: imageName)!, size: size, contentMode: contentMode, makeRound: makeRound)
        }
        
        /** Quick thumbail property generator */
        public static func thumb(with image: UIImage, edgeSize: CGFloat) -> ImageContent {
            return ImageContent(image: image, size: CGSize(width: edgeSize, height: edgeSize), contentMode: .scaleAspectFill, makeRound: true)
        }
        
        /** Quick thumbail property generator */
        public static func thumb(with imageName: String, edgeSize: CGFloat) -> ImageContent {
            return ImageContent(imageName: imageName, size: CGSize(width: edgeSize, height: edgeSize), contentMode: .scaleAspectFill, makeRound: true)
        }
    }
    
    /** Text field content **/
    public struct TextFieldContent {
        
        // NOTE: Intentionally a reference type
        class Output {
            var text = ""
        }
        
        public var keyboardType: UIKeyboardType
        public var isSecure: Bool
        public var leadingImage: UIImage!
        public var placeholder: LabelContent
        public var textStyle: LabelStyle
        public var bottomBorderColor: UIColor
        let outputWrapper = Output()
        public var output: String {
            return outputWrapper.text
        }
        
        public init(keyboardType: UIKeyboardType = .default, placeholder: LabelContent, textStyle: LabelStyle, isSecure: Bool = false, leadingImage: UIImage? = nil, bottomBorderColor: UIColor = .clear) {
            self.keyboardType = keyboardType
            self.placeholder = placeholder
            self.textStyle = textStyle
            self.isSecure = isSecure
            self.leadingImage = leadingImage
            self.bottomBorderColor = bottomBorderColor
        }
    }
    
    /** Button bar content */
    public struct ButtonBarContent {
        public var content: [ButtonContent] = []
        public var separatorColor: UIColor
        public var expandAnimatedly: Bool
        
        public init(with buttonContents: ButtonContent..., separatorColor: UIColor, expandAnimatedly: Bool) {
            self.separatorColor = separatorColor
            self.expandAnimatedly = expandAnimatedly
            content.append(contentsOf: buttonContents)
        }
    }
}
