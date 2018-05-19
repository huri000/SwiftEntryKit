//
//  UILabel+Message.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 04/14/2018.
//  Copyright (c) 2018 huri000@gmail.com. All rights reserved.
//

import UIKit
import QuickLayout

extension UILabel {
    var attributes: EKProperty.LabelStyle {
        set {
            font = newValue.font
            textColor = newValue.color
        }
        get {
            return EKProperty.LabelStyle(font: font, color: textColor, alignment: textAlignment)
        }
    }
    
    var labelContent: EKProperty.LabelContent {
        set {
            text = newValue.text
            font = newValue.style.font
            textColor = newValue.style.color
            textAlignment = newValue.style.alignment
        }
        get {
            return EKProperty.LabelContent(text: text ?? "", style: EKProperty.LabelStyle(font: font, color: textColor, alignment: textAlignment))
        }
    }
}

extension UIButton {
    var buttonContent: EKProperty.ButtonContent {
        set {
            setTitle(newValue.label.text, for: .normal)
            setTitleColor(newValue.label.style.color, for: .normal)
            titleLabel?.font = newValue.label.style.font
            backgroundColor = newValue.backgroundColor
        }
        get {
            fatalError("buttonContent doesn't have a getter")
        }
    }
}

extension UIImageView {
    var imageContent: EKProperty.ImageContent {
        set {
            image = newValue.image
            contentMode = newValue.contentMode
            
            if let size = newValue.size {
                set(.width, of: size.width)
                set(.height, of: size.height)
            } else {
                forceContentWrap()
            }
            
            layoutIfNeeded()
            
            if newValue.makeRound {
                clipsToBounds = true
                layer.cornerRadius = max(bounds.width, bounds.height) * 0.5
            }
        }
        get {
            fatalError("imageContent doesn't have a getter")
        }
    }
}

extension UITextField {
    var textFieldContent: EKProperty.TextFieldContent {
        set {
            attributedPlaceholder = NSAttributedString(string: newValue.placeholder.text, attributes: [.font: newValue.placeholder.style.font, .foregroundColor: newValue.placeholder.style.color])
            keyboardType = newValue.keyboardType
            textColor = newValue.textStyle.color
            font = newValue.textStyle.font
            textAlignment = newValue.textStyle.alignment
            isSecureTextEntry = newValue.isSecure
        }
        get {
            fatalError("textFieldContent doesn't have a getter")
        }
    }
}
