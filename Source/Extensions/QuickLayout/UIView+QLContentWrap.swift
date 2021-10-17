//
//  QLView+QLContentWrap.swift
//  QuickLayout
//
//  Created by Daniel Huri on 11/21/17.
//

import Foundation
import UIKit


// MARK: Content Compression Resistance & Content Hugging Priority
public extension QLView {

    /**
     Force hugging and compression resistance for the given axes, using variadic parameter.
     - parameter axes: The axes
     */
    func forceContentWrap(_ axes: QLAxis...) {
        if axes.contains(.vertically) {
            verticalHuggingPriority = .required
            verticalCompressionResistancePriority = .required
        }
        if axes.contains(.horizontally) {
            horizontalHuggingPriority = .required
            horizontalCompressionResistancePriority = .required
        }
    }
    
    /**
     Force hugging and compression resistance vertically and horizontally.
     */
    func forceContentWrap() {
        contentHuggingPriority = .required
        contentCompressionResistancePriority = .required
    }
    
    /**
     Vertical hugging priority
     */
    var verticalHuggingPriority: QLPriority {
        set {
            setContentHuggingPriority(newValue, for: .vertical)
        }
        get {
            return contentHuggingPriority(for: .vertical)
        }
    }
    
    /**
     Horizontal hugging priority
     */
    var horizontalHuggingPriority: QLPriority {
        set {
            setContentHuggingPriority(newValue, for: .horizontal)
        }
        get {
            return contentHuggingPriority(for: .horizontal)
        }
    }
    
    /**
     Content hugging priority (Vertical & Horizontal)
     */
    var contentHuggingPriority: QLPriorityPair {
        set {
            horizontalHuggingPriority = newValue.horizontal
            verticalHuggingPriority = newValue.vertical
        }
        get {
            return QLPriorityPair(horizontalHuggingPriority, verticalHuggingPriority)
        }
    }
    
    /**
     Vertical content compression resistance priority
     */
    var verticalCompressionResistancePriority: QLPriority {
        set {
            setContentCompressionResistancePriority(newValue, for: .vertical)
        }
        get {
            return contentCompressionResistancePriority(for: .vertical)
        }
    }
    
    /**
     Horizontal content compression resistance priority
     */
    var horizontalCompressionResistancePriority: QLPriority {
        set {
            setContentCompressionResistancePriority(newValue, for: .horizontal)
        }
        get {
            return contentCompressionResistancePriority(for: .horizontal)
        }
    }
    
    /**
    Content compression resistance priority (Vertical & Horizontal)
     */
    var contentCompressionResistancePriority: QLPriorityPair {
        set {
            horizontalCompressionResistancePriority = newValue.horizontal
            verticalCompressionResistancePriority = newValue.vertical
        }
        get {
            return QLPriorityPair(horizontalCompressionResistancePriority, verticalCompressionResistancePriority)
        }
    }
}
