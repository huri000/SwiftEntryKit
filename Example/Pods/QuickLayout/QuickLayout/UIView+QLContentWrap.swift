//
//  UIView+QLContentWrap.swift
//  QuickLayout
//
//  Created by Daniel Huri on 11/21/17.
//

import Foundation

// MARK: Content Compression Resistance & Content Hugging Priority
public extension UIView {

    /**
     Force hugging and compression resistance for the given axes, using variadic parameter.
     - parameter axes: The axes
     */
    public func forceContentWrap(_ axes: QLAxis...) {
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
    public func forceContentWrap() {
        contentHuggingPriority = .required
        contentCompressionResistancePriority = .required
    }
    
    /**
     Vertical hugging priority
     */
    public var verticalHuggingPriority: UILayoutPriority {
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
    public var horizontalHuggingPriority: UILayoutPriority {
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
    public var contentHuggingPriority: QLPriorityPair {
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
    public var verticalCompressionResistancePriority: UILayoutPriority {
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
    public var horizontalCompressionResistancePriority: UILayoutPriority {
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
    public var contentCompressionResistancePriority: QLPriorityPair {
        set {
            horizontalCompressionResistancePriority = newValue.horizontal
            verticalCompressionResistancePriority = newValue.vertical
        }
        get {
            return QLPriorityPair(horizontalCompressionResistancePriority, verticalCompressionResistancePriority)
        }
    }
}
