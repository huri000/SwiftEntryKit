//
//  UIView+Responder.swift
//  SwiftEntryKit
//
//  Created by Daniel Huri on 5/17/18.
//

import UIKit

extension UIView {
    var containsFirstResponder: Bool {
        var contains = false
        for subview in subviews.reversed() where !contains {
            if subview.isFirstResponder {
                contains = true
            } else {
                contains = subview.containsFirstResponder
            }
        }
        return contains
    }
}
