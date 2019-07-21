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
        
        /** Button title label content descriptor */
        public var label: LabelContent
        
        /** Button background color */
        public var backgroundColor: EKColor
        public var highlightedBackgroundColor: EKColor

        /** Content edge inset */
        public var contentEdgeInset: CGFloat
        
        /** The display mode of the button */
        public var displayMode: EKAttributes.DisplayMode
        
        /** Accessibility identifier that identifies the button */
        public var accessibilityIdentifier: String?
        
        /** Action */
        public var action: Action?
        
        public init(label: LabelContent,
                    backgroundColor: EKColor,
                    highlightedBackgroundColor: EKColor,
                    contentEdgeInset: CGFloat = 5,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    accessibilityIdentifier: String? = nil,
                    action: @escaping Action = {}) {
            self.label = label
            self.backgroundColor = backgroundColor
            self.highlightedBackgroundColor = highlightedBackgroundColor
            self.contentEdgeInset = contentEdgeInset
            self.displayMode = displayMode
            self.accessibilityIdentifier = accessibilityIdentifier
            self.action = action
        }
        
        public func backgroundColor(for traitCollection: UITraitCollection) -> UIColor {
            return backgroundColor.color(for: traitCollection, mode: displayMode)
        }
        
        public func highlightedBackgroundColor(for traitCollection: UITraitCollection) -> UIColor {
            return highlightedBackgroundColor.color(for: traitCollection, mode: displayMode)
        }
        
        public func highlighedLabelColor(for traitCollection: UITraitCollection) -> UIColor {
            return label.style.color.with(alpha: 0.8).color(
                for: traitCollection,
                mode: label.style.displayMode
            )
        }
    }
    
    /** Label content descriptor */
    public struct LabelContent {
        
        /** The text */
        public var text: String
        
        /** The label's style */
        public var style: LabelStyle
        
        /** The label's accessibility ideentifier */
        public var accessibilityIdentifier: String?
        
        public init(text: String,
                    style: LabelStyle,
                    accessibilityIdentifier: String? = nil) {
            self.text = text
            self.style = style
            self.accessibilityIdentifier = accessibilityIdentifier
        }
    }
    
    /** Label style descriptor */
    public struct LabelStyle {
        
        /** Font of the text */
        public var font: UIFont
        
        /** Color of the text */
        public var color: EKColor
        
        /** Text Alignment */
        public var alignment: NSTextAlignment
        
        /** Number of lines */
        public var numberOfLines: Int
        
        /** Display mode for the label */
        public var displayMode: EKAttributes.DisplayMode
        
        public init(font: UIFont,
                    color: EKColor,
                    alignment: NSTextAlignment = .left,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    numberOfLines: Int = 0) {
            self.font = font
            self.color = color
            self.alignment = alignment
            self.displayMode = displayMode
            self.numberOfLines = numberOfLines
        }
        
        public func color(for traitCollection: UITraitCollection) -> UIColor {
            return color.color(for: traitCollection, mode: displayMode)
        }
    }
    
    /** Image View style descriptor */
    public struct ImageContent {
        
        /** Repeated-reversed animation throughout the presentation of an image */
        public enum TransformAnimation {
            case animate(duration: TimeInterval, options: UIView.AnimationOptions, transform: CGAffineTransform)
            case none
        }
        
        /** Tint color for the image/s */
        public var tint: EKColor?
        
        /** The images */
        public var images: [UIImage]
        
        /** Image sequence duration, if any */
        public var imageSequenceAnimationDuration: TimeInterval
        
        /** Image View size - can be forced.
         If nil, then the image view hugs content and resists compression */
        public var size: CGSize?
    
        /** Content mode */
        public var contentMode: UIView.ContentMode
        
        /** Should the image be rounded */
        public var makesRound: Bool
        
        /** Repeated-Reversed animation */
        public var animation: TransformAnimation
        
        /** The display mode of the image */
        public var displayMode: EKAttributes.DisplayMode
        
        /** Image accessibility identifier */
        public var accessibilityIdentifier: String?
        
        public init(imageName: String,
                    animation: TransformAnimation = .none,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    size: CGSize? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    tint: EKColor? = nil,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            let image = UIImage(named: imageName)!
            self.init(image: image,
                      displayMode: displayMode,
                      size: size,
                      tint: tint,
                      contentMode: contentMode,
                      makesRound: makesRound,
                      accessibilityIdentifier: accessibilityIdentifier)
        }
        
        public init(image: UIImage,
                    animation: TransformAnimation = .none,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    size: CGSize? = nil,
                    tint: EKColor? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            self.images = [image]
            self.size = size
            self.tint = tint
            self.displayMode = displayMode
            self.contentMode = contentMode
            self.makesRound = makesRound
            self.animation = animation
            self.imageSequenceAnimationDuration = 0
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        
        public init(images: [UIImage],
                    imageSequenceAnimationDuration: TimeInterval = 1,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    animation: TransformAnimation = .none,
                    size: CGSize? = nil,
                    tint: EKColor? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            self.images = images
            self.size = size
            self.displayMode = displayMode
            self.tint = tint
            self.contentMode = contentMode
            self.makesRound = makesRound
            self.animation = animation
            self.imageSequenceAnimationDuration = imageSequenceAnimationDuration
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        
        public init(imagesNames: [String],
                    imageSequenceAnimationDuration: TimeInterval = 1,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    animation: TransformAnimation = .none,
                    size: CGSize? = nil,
                    tint: EKColor? = nil,
                    contentMode: UIView.ContentMode = .scaleToFill,
                    makesRound: Bool = false,
                    accessibilityIdentifier: String? = nil) {
            let images = imagesNames.map { return UIImage(named: $0)! }
            self.init(images: images,
                      imageSequenceAnimationDuration: imageSequenceAnimationDuration,
                      displayMode: displayMode,
                      animation: animation,
                      size: size,
                      tint: tint,
                      contentMode: contentMode,
                      makesRound: makesRound,
                      accessibilityIdentifier: accessibilityIdentifier)
        }
        
        /** Quick thumbail property generator */
        public static func thumb(with image: UIImage,
                                 edgeSize: CGFloat) -> ImageContent {
            return ImageContent(images: [image],
                                size: CGSize(width: edgeSize, height: edgeSize),
                                contentMode: .scaleAspectFill,
                                makesRound: true)
        }
        
        /** Quick thumbail property generator */
        public static func thumb(with imageName: String,
                                 edgeSize: CGFloat) -> ImageContent {
            return ImageContent(imagesNames: [imageName],
                                size: CGSize(width: edgeSize, height: edgeSize),
                                contentMode: .scaleAspectFill,
                                makesRound: true)
        }
        
        public func tintColor(for traitCollection: UITraitCollection) -> UIColor? {
            return tint?.color(for: traitCollection, mode: displayMode)
        }
    }
    
    /** Text field content **/
    public struct TextFieldContent {
        
        // NOTE: Intentionally a reference type
        class ContentWrapper {
            var text = ""
        }
        
        public var keyboardType: UIKeyboardType
        public var isSecure: Bool
        public var leadingImage: UIImage!
        public var placeholder: LabelContent
        public var textStyle: LabelStyle
        public var tintColor: EKColor!
        public var displayMode: EKAttributes.DisplayMode
        public var bottomBorderColor: EKColor
        public var accessibilityIdentifier: String?
        let contentWrapper = ContentWrapper()
        public var textContent: String {
            set {
                contentWrapper.text = newValue
            }
            get {
                return contentWrapper.text
            }
        }
        
        public init(keyboardType: UIKeyboardType = .default,
                    placeholder: LabelContent,
                    tintColor: EKColor? = nil,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    textStyle: LabelStyle,
                    isSecure: Bool = false,
                    leadingImage: UIImage? = nil,
                    bottomBorderColor: EKColor = .clear,
                    accessibilityIdentifier: String? = nil) {
            self.keyboardType = keyboardType
            self.placeholder = placeholder
            self.textStyle = textStyle
            self.tintColor = tintColor
            self.displayMode = displayMode
            self.isSecure = isSecure
            self.leadingImage = leadingImage
            self.bottomBorderColor = bottomBorderColor
            self.accessibilityIdentifier = accessibilityIdentifier
        }
        
        public func tintColor(for traitCollection: UITraitCollection) -> UIColor? {
            return tintColor?.color(for: traitCollection, mode: displayMode)
        }
        
        public func bottomBorderColor(for traitCollection: UITraitCollection) -> UIColor? {
            return bottomBorderColor.color(for: traitCollection, mode: displayMode)
        }
    }
    
    /** Button bar content */
    public struct ButtonBarContent {
        
        /** Button content array */
        public var content: [ButtonContent] = []
        
        /** The color of the separator */
        public var separatorColor: EKColor
        
        /** Upper threshold for the number of buttons (*ButtonContent*) for horizontal distribution. Must be a positive value */
        public var horizontalDistributionThreshold: Int
        
        /** Determines whether the buttons expands animately */
        public var expandAnimatedly: Bool
        
        /** The height of each button. All are equally distributed in their axis */
        public var buttonHeight: CGFloat
        
        /** The display mode of the button bar */
        public var displayMode: EKAttributes.DisplayMode
        
        public init(with buttonContents: ButtonContent...,
                    separatorColor: EKColor,
                    horizontalDistributionThreshold: Int = 2,
                    buttonHeight: CGFloat = 50,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    expandAnimatedly: Bool) {
            self.init(with: buttonContents,
                      separatorColor: separatorColor,
                      horizontalDistributionThreshold: horizontalDistributionThreshold,
                      buttonHeight: buttonHeight,
                      displayMode: displayMode,
                      expandAnimatedly: expandAnimatedly)
        }
        
        public init(with buttonContents: [ButtonContent],
                    separatorColor: EKColor,
                    horizontalDistributionThreshold: Int = 2,
                    buttonHeight: CGFloat = 50,
                    displayMode: EKAttributes.DisplayMode = .inferred,
                    expandAnimatedly: Bool) {
            guard horizontalDistributionThreshold > 0 else {
                fatalError("horizontalDistributionThreshold Must have a positive value!")
            }
            self.separatorColor = separatorColor
            self.horizontalDistributionThreshold = horizontalDistributionThreshold
            self.buttonHeight = buttonHeight
            self.displayMode = displayMode
            self.expandAnimatedly = expandAnimatedly
            content.append(contentsOf: buttonContents)
        }
        
        public func separatorColor(for traitCollection: UITraitCollection) -> UIColor {
            return separatorColor.color(for: traitCollection, mode: displayMode)
        }
    }
    
    /** Rating item content */
    public struct EKRatingItemContent {
        public var title: EKProperty.LabelContent
        public var description: EKProperty.LabelContent
        public var unselectedImage: EKProperty.ImageContent
        public var selectedImage: EKProperty.ImageContent
    
        public init(title: EKProperty.LabelContent,
                    description: EKProperty.LabelContent,
                    unselectedImage: EKProperty.ImageContent,
                    selectedImage: EKProperty.ImageContent) {
            self.title = title
            self.description = description
            self.unselectedImage = unselectedImage
            self.selectedImage = selectedImage
        }
    }
}
