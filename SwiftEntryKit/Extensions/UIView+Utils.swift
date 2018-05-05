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
    var attributes: EKProperty.Label {
        set {
            font = newValue.font
            textColor = newValue.color
        }
        get {
            return EKProperty.Label(font: font, color: textColor, alignment: textAlignment)
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
            return EKProperty.LabelContent(text: text ?? "", style: EKProperty.Label(font: font, color: textColor, alignment: textAlignment))
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
            let text = title(for: .normal)
            let color = titleColor(for: .normal)!
            return EKProperty.ButtonContent(label: EKProperty.LabelContent(text: text!, style: EKProperty.Label(font: titleLabel!.font, color: color, alignment: titleLabel!.textAlignment)), backgroundColor: backgroundColor!)
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
