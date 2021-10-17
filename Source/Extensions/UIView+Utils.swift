//
//  UILabel+Message.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit

extension UILabel {
    var style: EKProperty.LabelStyle {
        set {
            font = newValue.font
            textColor = newValue.color(for: traitCollection)
            textAlignment = newValue.alignment
            numberOfLines = newValue.numberOfLines
        }
        get {
            return EKProperty.LabelStyle(font: font,
                                         color: EKColor(textColor),
                                         alignment: textAlignment,
                                         numberOfLines: numberOfLines)
        }
    }
    
    var content: EKProperty.LabelContent {
        set {
            text = newValue.text
            accessibilityIdentifier = newValue.accessibilityIdentifier
            style = newValue.style
        }
        get {
            return EKProperty.LabelContent(text: text ?? "", style: style)
        }
    }
}

extension UIButton {
    var buttonContent: EKProperty.ButtonContent {
        set {
            setTitle(newValue.label.text, for: .normal)
            setTitleColor(newValue.label.style.color(for: traitCollection), for: .normal)
            titleLabel?.font = newValue.label.style.font
            accessibilityIdentifier = newValue.accessibilityIdentifier
            backgroundColor = newValue.backgroundColor.color(
                for: traitCollection,
                mode: newValue.displayMode
            )
        }
        get {
            fatalError("buttonContent doesn't have a getter")
        }
    }
}

extension UIImageView {
    var imageContent: EKProperty.ImageContent {
        set {
            stopAnimating()
            if newValue.images.count == 1 {
                image = newValue.images.first
            } else {
                animationImages = newValue.images.map {
                    $0.withRenderingMode(.alwaysTemplate)
                }
                animationDuration = newValue.imageSequenceAnimationDuration
            }
            
            contentMode = newValue.contentMode
            tintColor = newValue.tint?.color(for: traitCollection,
                                             mode: newValue.displayMode)
            accessibilityIdentifier = newValue.accessibilityIdentifier
            
            if let size = newValue.size {
                set(.width, of: size.width)
                set(.height, of: size.height)
            } else {
                forceContentWrap()
            }
            
            if newValue.makesRound {
                clipsToBounds = true
                if let size = newValue.size {
                    layer.cornerRadius = min(size.width, size.height) * 0.5
                } else {
                    layoutIfNeeded()
                    layer.cornerRadius = min(bounds.width, bounds.height) * 0.5
                }
            }
            
            startAnimating()
            
            if case .animate(duration: let duration,
                             options: let options,
                             transform: let transform) = newValue.animation {
                let options: UIView.AnimationOptions = [.repeat, .autoreverse, options]
                // A hack that forces the animation to run on the main thread,
                // on one of the next run loops
                DispatchQueue.main.async {
                    UIView.animate(withDuration: duration,
                                   delay: 0,
                                   options: options,
                                   animations: {
                        self.transform = transform
                    }, completion: nil)
                }
            }
        }
        get {
            fatalError("imageContent doesn't have a getter")
        }
    }
}

extension UITextField {
    
    var placeholder: EKProperty.LabelContent {
        set {
            attributedPlaceholder = NSAttributedString(
                string: newValue.text,
                attributes: [
                    .font: newValue.style.font,
                    .foregroundColor: newValue.style.color(for: traitCollection)
                ]
            )
        }
        get {
            fatalError("placeholder doesn't have a getter")
        }
    }
    
    var textFieldContent: EKProperty.TextFieldContent {
        set {
            placeholder = newValue.placeholder
            keyboardType = newValue.keyboardType
            textColor = newValue.textStyle.color(for: traitCollection)
            font = newValue.textStyle.font
            textAlignment = newValue.textStyle.alignment
            isSecureTextEntry = newValue.isSecure
            text = newValue.textContent
            tintColor = newValue.tintColor(for: traitCollection)
            accessibilityIdentifier = newValue.accessibilityIdentifier
        }
        get {
            fatalError("textFieldContent doesn't have a getter")
        }
    }
}
